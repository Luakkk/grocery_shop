import SwiftUI

struct CodeVerifyView: View {
    let verificationID: String
    @StateObject private var viewModel = CodeVerifyViewModel()
    @State private var smsCode = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter 6-digit code")
                .font(.title).bold()

            TextField("------", text: $smsCode)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Button("Verify") {
                viewModel.verifyCode(code: smsCode, verificationID: verificationID)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Spacer()
        }
        .padding()
    }
}
