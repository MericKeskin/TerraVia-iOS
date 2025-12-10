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
    
    @FocusState private var emailFocusState: Bool
    
    @FocusState private var passwordFocusState: Bool
    
    @FocusState private var checkPasswordFocusState: Bool
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            backButtonConfiguration: .custom(action: viewModel.backButtonTapped),
            titleConfiguration: .normal(title: viewModel.navigationTitle)
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
        .onAppear {
            bindStates()
        }
    }
}

// MARK: - Binding

extension RegisterView {
    
    func bindStates() {
        viewModel.emailFocusState = $emailFocusState
        viewModel.passwordFocusState = $passwordFocusState
        viewModel.checkPasswordFocusState = $checkPasswordFocusState
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
                .font(.cormorantGaramond(weight: .semiBold, size: 40))
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 16)
    }
    
    func registerContent(namespace: Namespace.ID) -> some View {
        VStack(spacing: 8) {
            TVTextField(
                "Email",
                input: $viewModel.email,
                font: .raleway(size: 22),
                focused: $emailFocusState,
                height: 56
            )
            .keyboardType(.emailAddress)
            .matchedGeometryEffect(id: "register_input_stack", in: namespace)
            
            TVButton(
                title: "Continue",
                font: .raleway(weight: .bold, size: 22),
                height: 48,
                fill: true,
                isDisabled: viewModel.invalidEmail,
                isLoading: viewModel.isLoading
            ) {
                viewModel.continueButtonTapped(with: viewModel.email)
            }
            .matchedGeometryEffect(id: "register_button_stack", in: namespace)
            
            Spacer()
            
            TVButton(
                title: "Test Route Dashboard",
                font: .raleway(weight: .bold, size: 22),
                height: 48,
                fill: true,
            ) {
                viewModel.coordinator.navigate(to: .dashboard(.home), resetting: true)
            }
        }
    }
    
    func signUpContent(namespace: Namespace.ID) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                TVTextField(
                    "Password",
                    input: $viewModel.password,
                    focused: $passwordFocusState,
                    height: 56,
                    isSecured: true,
                    isError: viewModel.isPasswordError,
                    errorField: {
                        Text("Not a valid password")
                            .font(.raleway(size: 12))
                    }
                )

                TVTextField(
                    "Check Password",
                    input: $viewModel.checkPassword,
                    textFieldStyle: .outlined(with: .secondary),
                    focused: $checkPasswordFocusState,
                    height: 56,
                    isSecured: true,
                    isError: viewModel.isCheckPasswordError,
                    errorField: {
                        Text("Password does not match")
                            .font(.raleway(size: 12))
                    }
                )
            }
            .matchedGeometryEffect(id: "register_input_stack", in: namespace)
            
            Spacer()
            
            TVButton(
                title: "Sign Up",
                font: .raleway(weight: .bold, size: 22),
                height: 48,
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
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                TVTextField(
                    "Password",
                    input: $viewModel.password,
                    focused: $passwordFocusState,
                    height: 56,
                    isSecured: true,
                    isError: viewModel.isPasswordError,
                    errorField: {
                        Text("Not a valid password")
                            .font(.raleway(size: 12))
                    },
                )
                
                TVButton(
                    label: {
                        Text("Forgot password?")
                            .foregroundStyle(.accent)
                            .font(.raleway(weight: .semiBold, size: 16))
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
                font: .raleway(weight: .bold, size: 22),
                height: 48,
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
            buttonStyle: .clear,
            horizontalPadding: 0,
            verticalPadding: 0
        ) {
            viewModel.anotherMethodButtonTapped()
        }
    }
}

#Preview {
    let coordinator: AuthCoordinator = .shared
    let viewModel = RegisterViewModel(coordinator: coordinator, scene: .login)
    RegisterView(viewModel: viewModel)
}
