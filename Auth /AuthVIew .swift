//
//  AuthVIew .swift
//  TastyHub
//
//  Created by Роман  on 18.12.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()  // Инициализация ViewModel
    @State private var email: String = ""  // Состояние для хранения email
    @State private var password: String = ""  // Состояние для хранения пароля
    @State private var isSignUp = false  // Переключатель между регистрацией и входом

    var body: some View {
        VStack {
            Text(isSignUp ? "Регистрация" : "Вход")
                .font(.largeTitle)
                .padding()

            // Email TextField
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Password SecureField
            SecureField("Пароль", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Показать сообщение об ошибке
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Кнопка для входа или регистрации
            Button(action: {
                if isSignUp {
                    viewModel.signUp(email: email, password: password)
                } else {
                    viewModel.signIn(email: email, password: password)
                }
            }) {
                Text(isSignUp ? "Зарегистрироваться" : "Войти")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Переключатель между входом и регистрацией
            Button(action: {
                isSignUp.toggle()
            }) {
                Text(isSignUp ? "Уже есть аккаунт? Войти" : "Нет аккаунта? Зарегистрироваться")
                    .foregroundColor(.blue)
            }

            // Переход на главный экран после успешной авторизации
            if viewModel.isAuthenticated {
                Text("Добро пожаловать, \(email)!")
                    .padding()
                // Здесь можно добавить переход на главный экран
            }
        }
        .padding()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
