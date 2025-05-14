import Foundation
import FirebaseAuth

@MainActor
class VerificationViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var errorMessage: String?
    @Published var isVerified: Bool = false

    func digit(at index: Int) -> String {
        if index < code.count {
            let start = code.index(code.startIndex, offsetBy: index)
            return String(code[start])
        }
        return ""
    }

    func verifyCode(verificationID: String) {
        #if targetEnvironment(simulator)
        if code == "123456" {
            print("✅ Verified on simulator")
            isVerified = true  // ✅ добавлено
        } else {
            errorMessage = "Invalid test code"
        }
        #else
        let credential = PhoneAuthProvider.provider()
            .credential(withVerificationID: verificationID, verificationCode: code)

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                self.errorMessage = "❌ \(error.localizedDescription)"
                return
            }

            print("✅ Auth success: \(String(describing: result?.user.phoneNumber))")
            self.isVerified = true  // ✅ добавлено
        }
        #endif
    }

    func resendCode(for phoneNumber: String) {
        self.code = ""
        #if targetEnvironment(simulator)
        print("🧪 Simulated resend for \(phoneNumber)")
        #else
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { _, error in
            if let error = error {
                self.errorMessage = "❌ \(error.localizedDescription)"
            } else {
                print("📩 SMS resent to \(phoneNumber)")
            }
        }
        #endif
    }
}

