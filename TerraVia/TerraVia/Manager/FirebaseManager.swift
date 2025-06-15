//
//  FirebaseManager.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import FirebaseAuth

protocol FirebaseManagerProtocol {
    
    // MARK: Authentication
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void))
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void))
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
}

// MARK: - Authentication

extension FirebaseManager {
    
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let _ = result?.user {
                completion(true)
            } else {
                Log.error(FirebaseError.auth(failedWith: error))
                completion(false)
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = result?.user {
                completion(true)
            } else {
                Log.error(FirebaseError.auth(failedWith: error))
                completion(false)
            }
        }
    }
}
