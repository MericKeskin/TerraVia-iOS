//
//  RegisterView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: Owned Object
    
    @StateObject var viewModel: RegisterViewModel
    
    // MARK: Focus State
    
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isCheckPasswordFocused: Bool
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            titleConfiguration: .normal(viewModel.scene.navigationTitle)
        ) { namespace in
            VStack(spacing: 12) {
                if viewModel.scene != .register {
                    welcomeStack()
                        .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.6).delay(0.8)), removal: .opacity.animation(.easeIn(duration: 0.2))))
                }
                
                switch viewModel.scene {
                case .register:
                    registerContent(namespace: namespace)
                case .signUp:
                    signUpContent(namespace: namespace)
                case .login:
                    loginContent(namespace: namespace)
                }
                
                if viewModel.scene != .register {
                    anotherMethodStack()
                        .transition(.opacity)
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
        }
    }
}

// MARK: - Subviews

extension RegisterView {
    
    func welcomeStack() -> some View {
        VStack(spacing: 8) {
            Image(.app)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Welcome to \nTerraVia")
                .foregroundStyle(.tintPrimary)
                .font(.cormorantGaramond(weight: .semiBold, size: 40, relativeTo: .largeTitle))
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 16)
    }
    
    func registerContent(namespace: Namespace.ID) -> some View {
        VStack {
            VStack {
                TVTextField(
                    "Email",
                    input: $viewModel.email,
                    font: .raleway(size: 20),
                    height: 56
                )
                .keyboardType(.emailAddress)
            }
            .matchedGeometryEffect(id: "register_input_stack", in: namespace)
            
            TVButton(
                title: "Continue",
                font: .raleway(weight: .bold, size: 22, relativeTo: .headline),
                height: 56,
                fill: true,
                isDisabled: viewModel.invalidEmail,
                isLoading: viewModel.isLoading
            ) {
                viewModel.continueButtonTapped(with: viewModel.email)
            }
            .matchedGeometryEffect(id: "register_button_stack", in: namespace)
            
            Spacer()
        }
    }
    
    func signUpContent(namespace: Namespace.ID) -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                TVTextField(
                    "Password",
                    input: $viewModel.password,
                    style: .secure,
                    isError: viewModel.invalidPassword && !isPasswordFocused && !viewModel.password.isEmpty,
                    errorField: {
                        Text("Not a valid password")
                            .font(.raleway(size: 12))
                    },
                    height: 56
                )
                .focused($isPasswordFocused)

                TVTextField(
                    "Check Password",
                    input: $viewModel.checkPassword,
                    style: .secure,
                    isError: viewModel.invalidCheckPassword && !isCheckPasswordFocused && !viewModel.checkPassword.isEmpty,
                    errorField: {
                        Text("Password does not match")
                            .font(.raleway(size: 12))
                    },
                    height: 56
                )
                .focused($isCheckPasswordFocused)
            }
            .matchedGeometryEffect(id: "register_input_stack", in: namespace)
            
            Spacer()
            
            TVButton(
                title: "Sign Up",
                font: .raleway(weight: .bold, size: 22, relativeTo: .headline),
                height: 56,
                fill: true,
                isDisabled: viewModel.invalidPassword || viewModel.invalidCheckPassword,
                isLoading: viewModel.isLoading
            ) {
                viewModel.signUpButtonTapped()
            }
            .matchedGeometryEffect(id: "register_button_stack", in: namespace)
        }
    }
    
    func loginContent(namespace: Namespace.ID) -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                TVTextField(
                    "Password",
                    input: $viewModel.password,
                    style: .secure,
                    isError: viewModel.invalidPassword && !isPasswordFocused && !viewModel.password.isEmpty,
                    errorField: {
                        Text("Not a valid password")
                            .font(.raleway(size: 12))
                    },
                    height: 56
                )
                .focused($isPasswordFocused)
                
                TVButton(
                    label: {
                        Text("Forgot password?")
                            .foregroundStyle(.tintSecondary)
                            .font(.raleway(size: 16))
                    },
                    buttonStyle: .clear,
                    horizontalPadding: 0,
                    verticalPadding: 0
                ) {
                    viewModel.forgotPasswordButtonTapped()
                }
            }
            .matchedGeometryEffect(id: "register_input_stack", in: namespace)
            
            Spacer()
            
            TVButton(
                title: "Log In",
                font: .raleway(weight: .bold, size: 22, relativeTo: .headline),
                height: 56,
                fill: true,
                isDisabled: viewModel.invalidPassword,
                isLoading: viewModel.isLoading
            ) {
                viewModel.logInButtonTapped()
            }
            .matchedGeometryEffect(id: "register_button_stack", in: namespace)
        }
    }
    
    func anotherMethodStack() -> some View {
        TVButton(
            label: {
                Text("Want to register with another email or method?")
                    .foregroundStyle(.tintSecondary)
                    .font(.raleway(size: 16))
            },
            buttonStyle: .clear
        ) {
            viewModel.anotherMethodButtonTapped()
        }
    }
}

#Preview {
    let coordinator: AuthCoordinator = .shared
    var viewModel = RegisterViewModel(coordinator: coordinator, scene: .login)
    RegisterView(viewModel: viewModel)
}
