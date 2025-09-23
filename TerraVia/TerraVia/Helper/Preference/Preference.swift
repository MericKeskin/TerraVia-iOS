//
//  Preference.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.07.2025.
//

import Foundation
import Combine

protocol PreferenceProtocol {
    
    /// Binds the Preference instance to a ObservableObjectPublisher
    func bind(to publisher: ObservableObjectPublisher, in cancellables: inout Set<AnyCancellable>)
}

/// Property Wrapper for storing preferences with UserDefaults
@propertyWrapper
struct Preference<Value: Codable> {
    
    private let userDefaults: UserDefaults
    private let queue: DispatchQueue
    
    private var key: String
    private var defaultValue: Value
    
    private var subject: CurrentValueSubject<Value, Never>
    
    init(suiteName: String? = nil, key: PreferenceKey, defaultValue: Value) {
        self.userDefaults = Self.setUserDefaults(suiteName: suiteName)
        self.queue = DispatchQueue(label: "com.preference.\(key.rawValue)", attributes: .concurrent)
        self.key = key.rawValue
        self.defaultValue = defaultValue
        
        let initialValue = Self.read(from: key.rawValue, with: userDefaults) ?? defaultValue
        self.subject = .init(initialValue)
    }
    
    var wrappedValue: Value {
        get {
            queue.asyncAndWait {
                subject.value
            }
        }
        nonmutating set {
            queue.sync(flags: .barrier) {
                Self.write(newValue, to: key, with: userDefaults)

                subject.send(newValue)
            }
        }
    }
    
    var projectedValue: Preference<Value>.PreferencePublisher {
        PreferencePublisher(subject: subject)
    }
}

// MARK: - PreferencePublisher

extension Preference {
    
    struct PreferencePublisher: Publisher {
        
        typealias Output = Value
        typealias Failure = Never

        fileprivate var subject: CurrentValueSubject<Output, Failure>
        
        func receive<S>(subscriber: S) where Output == S.Input, S: Subscriber, S.Failure == Failure {
            subject.receive(subscriber: subscriber)
        }
    }
}

// MARK: PreferenceProtocol

extension Preference: PreferenceProtocol {
    
    func bind(to publisher: ObservableObjectPublisher, in cancellables: inout Set<AnyCancellable>) {
        subject
            .sink { _ in
                publisher.send()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UserDefaults

private extension Preference {
    
    static func setUserDefaults(suiteName: String?) -> UserDefaults {
        if let suiteName {
            UserDefaults(suiteName: suiteName) ?? .standard
        } else {
            .standard
        }
    }
    
    static func read(from key: String, with userDefaults: UserDefaults) -> Value? {
        guard let data = userDefaults.object(forKey: key) as? Data else {
            ErrorHandler.shared.register(PreferenceError.read(from: key))
            return nil
        }
        
        guard let value = try? JSONDecoder().decode(Value.self, from: data) else {
            ErrorHandler.shared.register(PreferenceError.decode)
            return nil
        }
        
        return value
    }
    
    static func write(_ value: Value, to key: String, with userDefaults: UserDefaults) {
        guard let data = try? JSONEncoder().encode(value) else {
            ErrorHandler.shared.register(PreferenceError.encode)
            return
        }
        
        userDefaults.set(data, forKey: key)
    }
}
