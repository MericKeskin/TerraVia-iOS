//
//  RegisterViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import Foundation
import Combine
import SwiftUI

final class RegisterViewModel: BaseViewModel<AuthCoordinator> {
    
    // MARK: Dependency
    
    private lazy var firebaseManager = managers.firebaseManager
    
    private var onboarded: Bool {
        appPreferenceProvider.onboarded
    }
    
    // MARK: Property
    
    @Published var scene: Scene = .register
    
    var navigationTitle: String {
        onboarded ? scene.navigationTitle : Scene.login.navigationTitle
    }
    
    @Published var email: String = "" {
        didSet {
            invalidEmail = !email.isValidEmail
        }
    }
    
    @Published var invalidEmail: Bool = true
    
    @Published var password: String = "" {
        didSet {
            invalidPassword = !password.isValidPassword
            invalidCheckPassword = password != checkPassword
        }
    }
    
    @Published var invalidPassword: Bool = true
    
    @Published var checkPassword: String = "" {
        didSet {
            invalidCheckPassword = password != checkPassword
        }
    }
    
    @Published var invalidCheckPassword: Bool = true
    
    // MARK: Lifecycle
    
    init(dependencyProvider: DependencyProviderProtocol = DependencyProvider.shared, coordinator: AuthCoordinator, scene: Scene = .register) {
        super.init(dependencyProvider: dependencyProvider, coordinator: coordinator)
        self.scene = scene
    }
}

// MARK: - View Actions

extension RegisterViewModel {
    
    func continueButtonTapped(with email: String) {
        submitEmail(email)
    }
    
    func signUpButtonTapped() {
        signUp()
    }
    
    func logInButtonTapped() {
        logIn()
    }
    
    func forgotPasswordButtonTapped() {
        routeForgotPassword()
    }
    
    func anotherMethodButtonTapped() {
        showRegister()
    }
    
    func backButtonTapped() {
        if scene == .register {
            routeBack()
        } else {
            showRegister()
        }
    }
}

// MARK: - Navigation

private extension RegisterViewModel {
    
    func showSignUp() {
        withAnimation(.easeInOut(duration: 1.2)) {
            scene = .signUp
        }
    }
    
    func showLogin() {
        withAnimation(.easeInOut(duration: 1.2)) {
            scene = .login
        }
    }
    
    func showRegister() {
        password = ""
        checkPassword = ""
        
        withAnimation(.easeInOut(duration: 1.2)) {
            scene = .register
        }
    }
    
    func routeForgotPassword() {
        coordinator.navigate(to: .auth(.forgotPassword))
    }
    
    func routeHome() {
        coordinator.navigate(to: .dashboard(.home), resetting: true)
    }
    
    func routeBack() {
        coordinator.pop()
    }
}

// MARK: - Firebase

private extension RegisterViewModel {
    
    func submitEmail(_ email: String) {
        self.isLoading = true
        
        self.firebaseManager.checkEmail(email: email) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let status):
                DispatchQueue.main.async {
                    if status {
                        self.showLogin()
                    } else if self.onboarded {
                        self.showSignUp()
                    } else {
                        self.errorHandler.register(RegisterError.notOnboarded)
                    }
                }
                
                self.isLoading = false
            case .failure:
                self.isLoading = false
            }
        }
    }
    
    func signUp() {
        self.isLoading = true
        
        firebaseManager.signUp(email: email, password: password) { [weak self] status in
            guard let self else { return }
            
            if status {
                self.routeHome()
            }
            
            self.isLoading = false
        }
    }
    
    func logIn() {
        self.isLoading = true
        
        firebaseManager.logIn(email: email, password: password) { [weak self] status in
            guard let self else { return }
            
            if status {
                self.routeHome()
            }
            
            self.isLoading = false
        }
    }
}

// MARK: - Enums

extension RegisterViewModel {
    
    // MARK: Scene
    
    enum Scene {
        
        case register
        case signUp
        case login
        
        var navigationTitle: String {
            switch self {
            case .register:
                "Sign Up or Login"
            case .signUp:
                "Sign Up"
            case .login:
                "Login"
            }
        }
    }
}
