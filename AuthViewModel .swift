//
//  AuthViewModel .swift
//  TastyHub
//
//  Created by Роман  on 18.12.2024.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false

    
    func signUp(email: String, password: String) {
        FirebaseAuthService.shared.signUp(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.isAuthenticated = true
                print("User signed up: \(user.email ?? "")")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func signIn(email: String, password: String) {
        FirebaseAuthService.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.isAuthenticated = true
                print("User signed in: \(user.email ?? "")")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
