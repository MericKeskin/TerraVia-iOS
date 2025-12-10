//
//  FirebaseManager.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import FirebaseAuth
import FirebaseFunctions
import FirebaseFirestore
import SwiftUI

protocol FirebaseManagerProtocol: BaseManager {
    
    // MARK: Authentication
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void))
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void))
    func checkEmail(email: String, completion: @escaping ((Result<Bool, Error>) -> Void))
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
}

// MARK: - Authentication

extension FirebaseManager {
    
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, signUpError in
            guard let self else { return }
            
            if let user = result?.user {
                let db = Firestore.firestore()
                let collection = db.collection("users-staging")
                let document = collection.document()
                let userData: [String: Any] = ["firebase_id": document.documentID,
                                               "email": user.email ?? "",
                                               "created_at": Timestamp(date: Date())]
                
                document.setData(userData) { [weak self] setDocError in
                    guard let self else { return }
                    
                    if let setDocError {
                        self.errorHandler.register(FirebaseError.firestore(failedWith: setDocError))
                    }
                }
                
                completion(true)
            } else {
                self.errorHandler.register(FirebaseError.signUp(failedWith: signUpError))
                
                completion(false)
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, loginError in
            guard let self else { return }
            
            if let user = result?.user {
                let db = Firestore.firestore()
                let docRef = db.collection("users-staging").document(user.uid)
                
                docRef.getDocument { [weak self] document, getDocError in
                    guard let self else { return }
                    
                    if let document {
                        if document.exists {
                            docRef.updateData(["lastLoginAt": Timestamp(date: Date())])
                        } else {
                            let userData: [String: Any] = ["email": user.email ?? "",
                                                           "createdAt": Timestamp(date: Date())]
                            
                            docRef.setData(userData) { [weak self] setDocError in
                                guard let self else { return }
                                
                                if let setDocError {
                                    self.errorHandler.register(FirebaseError.firestore(failedWith: setDocError))
                                }
                            }
                        }
                    } else {
                        self.errorHandler.register(FirebaseError.firestore(failedWith: getDocError))
                    }
                }
                
                completion(true)
            } else {
                self.errorHandler.register(FirebaseError.login(failedWith: loginError))
                completion(false)
            }
        }
    }
    
    func checkEmail(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Functions.functions().httpsCallable("emailCheck").call(["email": email]) { [weak self] result, error in
            guard let self else { return }
            
            if let error {
                self.errorHandler.register(FirebaseError.function(failedWith: error))
                
                completion(.failure(error))
                
                return
            }
            
            guard let data = result?.data as? [String: Any],
                  let registered = data["registered"] as? Bool else {
                self.errorHandler.register(FirebaseError.function(failedWith: FirebaseError.Reason.invalidResponse))

                completion(.failure(FirebaseError.Reason.invalidResponse))
                
                return
            }
            
            completion(.success(registered))
        }
    }
}
