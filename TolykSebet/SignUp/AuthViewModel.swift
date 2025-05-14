//
//  AuthViewModel.swift
//  TolykSebet
//
//  Created by Kemel Merey on 12.05.2025.
//

import FirebaseAuth
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var currentUser: UserModel?

    func register(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("✅ Registered as: \(result.user.email ?? "")")
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("✅ Logged in as: \(result.user.email ?? "")")
            isAuthenticated = true
            currentUser = UserModel(fullName: "", email: result.user.email ?? "")
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

