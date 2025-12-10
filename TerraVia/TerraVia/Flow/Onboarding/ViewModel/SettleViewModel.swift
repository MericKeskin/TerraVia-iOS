//
//  SettleViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI
import Combine

final class SettleViewModel: BaseViewModel<OnboardingCoordinator> {
    
    @Published var scene: Scene = .initialize
    
    // MARK: Progress Bar
    
    @Published var settleProgress: Double = 0
    
    let totalSettleProgress: Double = Scene.totalProgressAmount
    
    // MARK: Terry Header
    
    private var terryTypeTask: Task<Void, Never>?
    
    private var isTerryTypeTaskActive: Bool = false
    
    private var isTerryTypeTaskFastForward: Bool = false
    
    @Published var terryDisplayedText: String = ""
    
    @Published var terryRestText: String = ""
    
    @Published var terryHeadImage: ImageResource = .terryHeadSmiling
    
    // MARK: Greeting Scene
    
    @Published var isGreetingLoaded: Bool = false
    
    @Published var greetingDisplayedText: String = ""
    
    @Published var greetingRestText: String = ""
    
    var greetingHelloText: String {
        "Hello, I'm Terry!"
    }
    
    var greetingAskText: String {
        "What's your name?"
    }
    
    @Published var greetingName: String = "" {
        didSet {
            isContinueButtonDisabled = greetingName.isEmpty
        }
    }
    
    var greetingNameFocusState: FocusState<Bool>.Binding?
    
    // MARK: Language Scene
    
    @Published var selectedLanguage: LanguageTerry?
    
    let allLanguages: [LanguageTerry] = LanguageTerry.allCases
    
    @Published var isLanguageLoaded: Bool = false
    
    @Published var isLanguageGreetCompleted: Bool = false
    
    @Published var isLanguageListHidden: Bool = true
    
    var languageGreetText: String {
        "It's so nice to meet you! I can't wait to help you learn the world!"
    }
    
    var languageBeforeText: String {
        "Before we get started, I'm going to ask you some questions. Are you ready?"
    }
    
    var languageGreetCompletedText: String {
        "Great! Let's get started!"
    }
    
    var languageAskText: String {
        "Which language do you prefer to speak, \(getUsername())?"
    }
    
    // MARK: Continue Button
    
    @Published var isContinueButtonDisabled: Bool = true
}

// MARK: - View Actions

extension SettleViewModel {
    
    func viewAppeared() {
        if scene == .initialize {
            progressForwardWithAnimaton()
            settleForwardWithAnimation(to: .greeting, delay: 0.4)
            
            return
        }
        
        if scene == .finalize {
            progressBackwardWithAnimation()
            
            return
        }
    }
    
    func middleViewTapped() {
        if isTerryTypeTaskActive {
            isTerryTypeTaskFastForward = true
        }
    }
    
    func greetingAppeared() {
        isContinueButtonDisabled = greetingName.isEmpty
        
        guard !isGreetingLoaded else {
            greetingDisplayedText = greetingAskText
            
            return
        }
        
        isGreetingLoaded = true
        
        greetingTypeTask()
    }
    
    func languageAppeared() {
        isContinueButtonDisabled = selectedLanguage == nil
        
        guard !isLanguageLoaded else {
            terryDisplayedText = languageAskText
            
            showLanguageListWithAnimation(delay: 0.4)
            
            return
        }
        
        languageGreetTypeTask()
    }
    
    func languageListItemTapped(for language: LanguageTerry) {
        toggleSelectedLanguage(with: language)
        
        isContinueButtonDisabled = selectedLanguage == nil
    }
    
    func continueButtonTapped() {
        if scene == .language, !isLanguageLoaded {
            isContinueButtonDisabled = true
            
            languageAskTypeTask()
            
            return
        }
        
        saveInfo()
        
        guard let nextScene = scene.next else {
            routeForwardTask()
            
            return
        }
        
        if scene == .greeting {
            defocusTextFieldWithAnimation(with: &self.greetingNameFocusState)
        }
        
        progressForwardWithAnimaton()
        settleForwardWithAnimation(to: nextScene)
    }
    
    func backButtonTapped() {
        depleteInfo()
        
        guard let previousScene = scene.previous else {
            routeBackward()
            
            return
        }
        
        progressBackwardWithAnimation()
        settleBackwardWithAnimation(to: previousScene)
    }
}

// MARK: - Logic

private extension SettleViewModel {
    
    func startTyping(
        text: String,
        update: @escaping (String, String) -> Void,
        preparation: @escaping () -> Void = {},
        completion: @escaping () -> Void = {}
    ) async throws {
        var updateString = ""
        var restString = text
        
        preparation()
        
        for char in text {
            try Task.checkCancellation()
            try checkFastForward()
            
            updateString.append(char)
            restString.removeFirst()
            update(updateString, restString)
            
            try await Task.sleep(for: 0.02)
        }
            
        completion()
    }
    
    func checkFastForward() throws {
        if isTerryTypeTaskFastForward {
            throw SettleError.typeTaskFastForward
        }
    }
    
    func sleepOrFastForward(
        forSeconds seconds: Double,
        fastForwardCompletion: @escaping () -> Void
    ) async {
        await withTaskGroup { group in
            group.addTask {
                try? await Task.sleep(for: seconds)
                
                return
            }
            
            group.addTask { [weak self] in
                guard let self else { return }
                
                do {
                    while true {
                        try Task.checkCancellation()
                        try await checkFastForward()
                    }
                } catch {
                    fastForwardCompletion()
                    
                    return
                }
            }
            
            _ = await group.next()
            group.cancelAll()
            
            return
        }
    }
    
    func displayedTextUpdate(
        displayedText: inout String,
        restText: inout String,
        withDisplayed newDisplayedText: String,
        withRest newRestText: String
    ) {
        displayedText = newDisplayedText
        restText = newRestText
    }
    
    func greetingTypeTask() {
        isTerryTypeTaskActive = true
        
        terryTypeTask = Task {
            defer {
                isTerryTypeTaskActive = false
            }
            
            do {
                try await Task.sleep(for: 0.8)
                
                do {
                    try await startTyping(
                        text: greetingHelloText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.greetingDisplayedText,
                                                     restText: &self.greetingRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.greetingRestText = self.greetingHelloText
                        }
                    )
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &greetingDisplayedText,
                                        restText: &greetingRestText,
                                        withDisplayed: greetingHelloText,
                                        withRest: "")
                    
                    isTerryTypeTaskFastForward = false
                }
                
                await sleepOrFastForward(forSeconds: 0.8) { [weak self] in
                    guard let self else { return }
                    
                    isTerryTypeTaskFastForward = false
                }
                
                do {
                    try await startTyping(
                        text: greetingAskText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.greetingDisplayedText,
                                                     restText: &self.greetingRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.greetingRestText = self.greetingAskText
                        }
                    ) { [weak self] in
                        guard let self else { return }
                        
                        self.focusTextFieldWithAnimation(with: &self.greetingNameFocusState)
                    }
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &greetingDisplayedText,
                                        restText: &greetingRestText,
                                        withDisplayed: greetingAskText,
                                        withRest: "")
                    
                    focusTextFieldWithAnimation(with: &greetingNameFocusState)
                    
                    isTerryTypeTaskFastForward = false
                }
            } catch {
                if error is CancellationError {
                    greetingDisplayedText = ""
                }
            }
        }
    }
    
    func languageGreetTypeTask() {
        isTerryTypeTaskActive = true
        
        terryTypeTask = Task {
            defer {
                isTerryTypeTaskActive = false
            }
            
            do {
                try await Task.sleep(for: 0.4)
                
                do {
                    try await startTyping(
                        text: languageGreetText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.terryDisplayedText,
                                                     restText: &self.terryRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.terryRestText = self.languageGreetText
                            self.terryHeadImage = .terryHeadSincere
                        }
                    )
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &terryDisplayedText,
                                        restText: &terryRestText,
                                        withDisplayed: languageGreetText,
                                        withRest: "")
                    
                    isTerryTypeTaskFastForward = false
                }
                
                await sleepOrFastForward(forSeconds: 0.8) { [weak self] in
                    guard let self else { return }
                    
                    isTerryTypeTaskFastForward = false
                }
                
                do {
                    try await startTyping(
                        text: languageBeforeText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.terryDisplayedText,
                                                     restText: &self.terryRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.terryRestText = self.languageBeforeText
                            self.terryHeadImage = .terryHeadSmiling
                        }
                    ) { [weak self] in
                        guard let self else { return }
                        
                        self.isContinueButtonDisabled = false
                    }
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &terryDisplayedText,
                                        restText: &terryRestText,
                                        withDisplayed: languageBeforeText,
                                        withRest: "")
                    
                    self.isContinueButtonDisabled = false
                    
                    isTerryTypeTaskFastForward = false
                }
            } catch {
                if error is CancellationError {
                    terryDisplayedText = ""
                }
            }
        }
    }
    
    func languageAskTypeTask() {
        isTerryTypeTaskActive = true
        
        terryTypeTask = Task {
            defer {
                isTerryTypeTaskActive = false
            }
            
            do {
                do {
                    try await startTyping(
                        text: languageGreetCompletedText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.terryDisplayedText,
                                                     restText: &self.terryRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.terryRestText = self.languageGreetCompletedText
                            self.terryHeadImage = .terryHeadSincere
                        }
                    )
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &terryDisplayedText,
                                        restText: &terryRestText,
                                        withDisplayed: languageGreetCompletedText,
                                        withRest: "")
                    
                    isTerryTypeTaskFastForward = false
                }
                
                await sleepOrFastForward(forSeconds: 0.8) { [weak self] in
                    guard let self else { return }
                    
                    isTerryTypeTaskFastForward = false
                }
                
                do {
                   try await startTyping(
                        text: languageAskText,
                        update: { [weak self] displayed, rest in
                            guard let self else { return }
                            
                            self.displayedTextUpdate(displayedText: &self.terryDisplayedText,
                                                     restText: &self.terryRestText,
                                                     withDisplayed: displayed,
                                                     withRest: rest)
                        },
                        preparation: { [weak self] in
                            guard let self else { return }
                            
                            self.terryRestText = self.languageAskText
                            self.terryHeadImage = .terryHeadSmiling
                        }
                    ) { [weak self] in
                        guard let self else { return }
                        
                        isLanguageLoaded = true
                        showLanguageListWithAnimation()
                    }
                } catch is SettleError {
                    displayedTextUpdate(displayedText: &terryDisplayedText,
                                        restText: &terryRestText,
                                        withDisplayed: languageAskText,
                                        withRest: "")
                    
                    isLanguageLoaded = true
                    showLanguageListWithAnimation()
                    
                    isTerryTypeTaskFastForward = false
                }
            } catch {
                if error is CancellationError {
                    terryDisplayedText = ""
                }
            }
        }
    }
    
    func progressForwardWithAnimaton(
        duration: TimeInterval = 0.8,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            settleProgress += scene.progressAmount
        }
    }
    
    func progressBackwardWithAnimation(
        duration: TimeInterval = 0.8,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeOut(duration: duration).delay(delay)) {
            settleProgress -= scene.progressAmount
        }
    }
    
    func settleForwardWithAnimation(
        to nextScene: Scene,
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            scene = nextScene
        }
    }
    
    func settleBackwardWithAnimation(
        to previousScene: Scene,
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            scene = previousScene
        }
    }
    
    func routeForwardTask() {
        Task {
            progressForwardWithAnimaton(duration: 0.8)
            
            try? await Task.sleep(for: 0.8)
            
            routeRegister()
        }
    }
    
    func routeBackward() {
        routeBack()
    }
    
    func focusTextFieldWithAnimation(
        with focusState: inout FocusState<Bool>.Binding?,
        duration: TimeInterval = 0.2,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.smooth(duration: duration).delay(delay)) {
            focusState?.focus()
        }
    }
    
    func defocusTextFieldWithAnimation(
        with focusState: inout FocusState<Bool>.Binding?,
        duration: TimeInterval = 0.2,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.smooth(duration: duration).delay(delay)) {
            focusState?.defocus()
        }
    }
    
    func showLanguageListWithAnimation(
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.0
    ) {
        if isLanguageListHidden {
            withAnimation(.easeIn(duration: duration).delay(delay)) {
                isLanguageListHidden = false
            }
        }
    }
    
    func hideLanguageListWithAnimation(
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.0
    ) {
        if !isLanguageListHidden {
            withAnimation(.easeOut(duration: duration).delay(delay)) {
                isLanguageListHidden = true
            }
        }
    }
    
    func toggleSelectedLanguage(with language: LanguageTerry) {
        withAnimation {
            selectedLanguage = selectedLanguage == language ? nil : language
        }
    }
    
    func saveInfo() {
        switch scene {
        case .initialize:
            return
        case .greeting:
            setUsername()
        case .language:
            setLanguageTerry()
        case .personality:
            return
        case .notification:
            return
        case .finalize:
            setOnboarded()
        }
    }
    
    func depleteInfo() {
        terryTypeTask?.cancel()
        terryDisplayedText = ""
        
        switch scene {
        case .initialize:
            return
        case .greeting:
            resetOnboarded()
        case .language:
            hideLanguageListWithAnimation()
        case .personality:
            return
        case .notification:
            return
        case .finalize:
            return
        }
    }
}

// MARK: - Navigation

private extension SettleViewModel {
    
    func routeRegister() {
        coordinator.navigate(to: .auth(.register))
    }
    
    func routeBack() {
        coordinator.pop()
    }
}

// MARK: - Preference

private extension SettleViewModel {
    
    func getUsername() -> String {
        appPreferenceProvider.username
    }
    
    func setUsername() {
        appPreferenceProvider.username = greetingName
    }
    
    func setLanguageTerry() {
        guard let selectedLanguage else { return }
        
        appPreferenceProvider.languageTerry = selectedLanguage
    }
    
    func setOnboarded() {
        appPreferenceProvider.onboarded = true
    }
    
    func resetOnboarded() {
        appPreferenceProvider.onboarded = false
    }
}

// MARK: - Enums

extension SettleViewModel {
    
    enum Scene: Int, CaseIterable {
        
        case initialize
        case greeting = 1
        case language
        case personality
        case notification
        case finalize
        
        var next: Self? {
            let all = Self.allCases
            
            guard self.rawValue < all.count - 1 else { return nil }
            
            return all[self.rawValue+1]
        }

        var previous: Self? {
            let all = Self.allCases
            
            guard self.rawValue > 1 else { return nil }
            
            return all[self.rawValue-1]
        }
        
        var progressAmount: Double {
            switch self {
            case .initialize:
                3
            case .greeting:
                5
            case .language:
                5
            case .personality:
                5
            case .notification:
                5
            case .finalize:
                4
            }
        }
        
        static var totalProgressAmount: Double {
            Self.allCases.map { $0.progressAmount }.reduce(0, +)
        }
    }
}
