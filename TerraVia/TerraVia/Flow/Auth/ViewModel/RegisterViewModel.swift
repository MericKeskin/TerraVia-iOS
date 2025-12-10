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
    
    var emailFocusState: FocusState<Bool>.Binding?
    
    @Published var invalidEmail: Bool = true
    
    @Published var password: String = "" {
        didSet {
            invalidPassword = !password.isValidPassword
            invalidCheckPassword = password != checkPassword
        }
    }
    
    var passwordFocusState: FocusState<Bool>.Binding?
    
    var isPasswordFocused: Bool {
        passwordFocusState?.wrappedValue == true
    }
    
    @Published var invalidPassword: Bool = true
    
    var isPasswordError: Bool {
        invalidPassword && !isPasswordFocused && !password.isEmpty
    }
    
    @Published var checkPassword: String = "" {
        didSet {
            invalidCheckPassword = password != checkPassword
        }
    }
    
    var checkPasswordFocusState: FocusState<Bool>.Binding?
    
    var isCheckPasswordFocused: Bool {
        checkPasswordFocusState?.wrappedValue == true
    }
    
    @Published var invalidCheckPassword: Bool = true
    
    var isCheckPasswordError: Bool {
        invalidCheckPassword && !isCheckPasswordFocused && !checkPassword.isEmpty
    }
    
    // MARK: Lifecycle
    
    init(
        dependencyProvider: DependencyProviderProtocol = DependencyProvider.shared,
        coordinator: AuthCoordinator,
        scene: Scene = .register
    ) {
        super.init(dependencyProvider: dependencyProvider, coordinator: coordinator)
        
        self.scene = scene
    }
}

// MARK: - View Actions

extension RegisterViewModel {
    
    func continueButtonTapped(with email: String) {
        defocusTextFieldWithAnimation(with: &emailFocusState)
        
        submitEmail(email)
    }
    
    func signUpButtonTapped() {
        defocusTextFieldWithAnimation(with: &passwordFocusState)
        defocusTextFieldWithAnimation(with: &checkPasswordFocusState)
        
        signUp()
    }
    
    func logInButtonTapped() {
        defocusTextFieldWithAnimation(with: &passwordFocusState)
        
        logIn()
    }
    
    func forgotPasswordButtonTapped() {
        defocusTextFieldWithAnimation(with: &passwordFocusState)
        
        routeForgotPassword()
    }
    
    func anotherMethodButtonTapped() {
        defocusTextFieldWithAnimation(with: &passwordFocusState)
        defocusTextFieldWithAnimation(with: &checkPasswordFocusState)
        
        showRegisterWithAnimation()
    }
    
    func backButtonTapped() {
        if scene == .register {
            routeBack()
        } else {
            showRegisterWithAnimation()
        }
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
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    if status {
                        showLoginWithAnimation()
                    } else if onboarded {
                        showSignUpWithAnimation()
                    } else {
                        errorHandler.register(RegisterError.notOnboarded)
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

// MARK: - Logic

private extension RegisterViewModel {
    
    func showSignUpWithAnimation(
        duration: TimeInterval = 0.8,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            scene = .signUp
        }
    }
    
    func showLoginWithAnimation(
        duration: TimeInterval = 0.8,
        delay: TimeInterval = 0.0
    ) {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            scene = .login
        }
    }
    
    func showRegisterWithAnimation(
        duration: TimeInterval = 0.8,
        delay: TimeInterval = 0.0
    ) {
        password = ""
        checkPassword = ""
        
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            scene = .register
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
}

// MARK: - Navigation

private extension RegisterViewModel {
    
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
