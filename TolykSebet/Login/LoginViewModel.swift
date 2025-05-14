import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String?

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.errorMessage = nil
                    print("✅ User logged in: \(result?.user.email ?? "No Email")")
                }
            }
        }
    }
}
