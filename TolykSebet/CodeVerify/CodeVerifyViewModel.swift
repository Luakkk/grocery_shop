import Foundation
import FirebaseAuth

class CodeVerifyViewModel: ObservableObject {
    @Published var errorMessage: String?

    func verifyCode(code: String, verificationID: String) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code
        )

        Auth.auth().signIn(with: credential) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Verification failed: \(error.localizedDescription)"
                } else {
                    print("✅ User logged in with phone: \(result?.user.phoneNumber ?? "")")
                    self.errorMessage = nil
                    // тут можно перейти на главный экран
                }
            }
        }
    }
}
