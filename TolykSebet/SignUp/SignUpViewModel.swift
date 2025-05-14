import Foundation
import FirebaseAuth

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var model = SignUpModel()
    @Published var errorMessage: String?

    func register() async -> Bool {
        guard model.password == model.confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }

        do {
            try await Auth.auth().createUser(withEmail: model.email, password: model.password)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}



