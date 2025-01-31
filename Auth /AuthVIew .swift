//
//  AuthVIew .swift
//  TastyHub
//
//  Created by Роман  on 18.12.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isSignUp = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.green.opacity(0.5)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("🍽 Tasty Hub")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)

                    Text(isSignUp ? "Create Account" : "Login to Continue")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.bottom, 20)

                    VStack(spacing: 15) {
                        
                        CustomTextField(placeholder: "Email", text: $email, icon: "envelope")
                        
                        
                        CustomTextField(placeholder: "Password", text: $password, icon: "lock", isSecure: true)
                        
                        
                        if isSignUp {
                            CustomTextField(placeholder: "Confirm Password", text: $confirmPassword, icon: "lock.fill", isSecure: true)
                        }
                    }
                    .padding(.horizontal, 30)

                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    
                    Button(action: handleAuth) {
                        Text(isSignUp ? "Sign Up" : "Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                    
                    HStack {
                        Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                            .foregroundColor(.white.opacity(0.8))
                        
                        Button(action: { isSignUp.toggle() }) {
                            Text(isSignUp ? "Log In" : "Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 15)
                }
                .padding()
            }
        }
    }

    
    private func handleAuth() {
        errorMessage = nil

        if isSignUp {
            
            guard password == confirmPassword else {
                errorMessage = "Passwords do not match"
                return
            }
            viewModel.signUp(email: email, password: password)
        } else {
            viewModel.signIn(email: email, password: password)
        }
    }
}


struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var icon: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .foregroundColor(.white)
    }
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
