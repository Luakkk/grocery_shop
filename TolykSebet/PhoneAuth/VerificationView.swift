import SwiftUI

struct VerificationView: View {
    let verificationID: String
    let phoneNumber: String

    @StateObject private var viewModel = VerificationViewModel()
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    @State private var isVerified = false  
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                // 🔙 Back
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }

                Text("Enter your 6-digit code")
                    .font(.system(size: 24, weight: .semibold))

                Text("Code")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                ZStack {
                    HStack(spacing: 14) {
                        ForEach(0..<6, id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .frame(width: 45, height: 55)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(.systemGray6))

                                Text(viewModel.digit(at: index))
                                    .font(.title2)
                            }
                        }
                    }

                    // Скрытый TextField
                    TextField("", text: $viewModel.code)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .frame(width: 0, height: 0)
                        .opacity(0.001)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isFocused = true
                            }
                        }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }

                Spacer()

                HStack {
                    Button("Resend Code") {
                        viewModel.resendCode(for: phoneNumber)
                    }
                    .foregroundColor(.green)
                    .font(.system(size: 16, weight: .medium))

                    Spacer()

                    Button {
                        viewModel.verifyCode(verificationID: verificationID)
                    } label: {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(Color.green))
                    }
                    .disabled(viewModel.code.count != 6)
                    .opacity(viewModel.code.count != 6 ? 0.3 : 1)
                }
                NavigationLink(
                    destination: MainTabView(),
                    isActive: $isVerified,
                    label: { EmptyView() }
                )
                .hidden()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .onReceive(viewModel.$isVerified) { value in
                if value {
                    isVerified = true
                }
            }
        }
    }
}

