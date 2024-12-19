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
    @Published var isSignedIn: Bool = false

    
    func signUp(email: String, password: String) {
        FirebaseAuthService.shared.signUp(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isSignedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signIn(email: String, password: String) {
        FirebaseAuthService.shared.signIn(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isSignedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
