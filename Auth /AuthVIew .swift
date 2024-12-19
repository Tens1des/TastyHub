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
    @State private var isSignUp = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isSignedIn {
                    NavigationLink(destination: MainView(), isActive: $viewModel.isSignedIn) {
                        EmptyView()
                    }
                }
                
                Text("Welcome")
                    .font(.largeTitle)
                    .offset(y: -60)
                
                VStack (alignment: .leading, spacing: 8){
                    Text(isSignUp ? "Create your Account" : "Login to your Account")
                        .font(.title2)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .offset(x:20)
    
                    
                    Text("Email")
                        .font(.caption) // Меньший шрифт для описания
                        .foregroundColor(.black)
                        .offset(x: 20 , y: 20)
                    
                    
                    TextField("Email", text: $email)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.black)
                        .offset(x:20 , y:-3)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .offset(y: -23)
                        
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: {
                    if isSignUp {
                        viewModel.signUp(email: email, password: password)
                    } else {
                        viewModel.signIn(email: email, password: password)
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Log In")
                        .frame(maxWidth: 300 , alignment: .center)
                        
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(25)
                        .offset(y: -25)
                        
                        
                }

                HStack {
                    
                    Text(isSignUp ? "Already have an Account ?" : "Don't have an account ?")
                        .foregroundColor(.black)
                    
                    
                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Log In" : "Sign Up")
                            .foregroundColor(.mint)
                    }
                }.offset(y: 160)
            }
            .padding()
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Главный экран")
            .font(.largeTitle)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
