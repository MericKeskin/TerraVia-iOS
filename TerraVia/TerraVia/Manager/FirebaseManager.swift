//
//  FirebaseManager.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import FirebaseAuth
import FirebaseFunctions
import FirebaseFirestore

protocol FirebaseManagerProtocol {
    
    // MARK: Authentication
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void))
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void))
    func checkEmail(email: String, completion: @escaping ((Result<Bool, Error>) -> Void))
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    
    let errorHandler: ErrorHandler = .shared
}

// MARK: - Authentication

extension FirebaseManager {
    
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let userData: [String: Any] = [
                    "uid": user.uid,
                    "email": user.email ?? "",
                    "createdAt": Timestamp(date: Date())
                ]
                
                let db = Firestore.firestore()
                db.collection("users-staging").document(user.uid).setData(userData) { firestoreError in
                    if let firestoreError = firestoreError {
                        self.errorHandler.register(FirebaseError.signUp(failedWith: firestoreError))
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            } else {
                self.errorHandler.register(FirebaseError.signUp(failedWith: error))
                completion(false)
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = result?.user {
                completion(true)
            } else {
                self.errorHandler.register(FirebaseError.login(failedWith: error))
                completion(false)
            }
        }
    }
    
    func checkEmail(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Functions.functions().httpsCallable("emailCheck").call(["email": email]) { result, error in
            if let error {
                self.errorHandler.register(FirebaseError.function(failedWith: error))
                completion(.failure(error))
                return
            }
            
            guard let data = result?.data as? [String: Any],
                  let registered = data["registered"] as? Bool else {
                self.errorHandler.register(FirebaseError.function(failedWith: FirebaseError.invalidResponse))
                return
            }
            
            completion(.success(registered))
        }
    }
}
