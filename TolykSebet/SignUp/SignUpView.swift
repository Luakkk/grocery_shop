import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject var authVM: AuthViewModel

    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var goToDetails = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)

                Text("Enter your credentials to continue")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }

            Group {
                TextField("Full Name", text: $viewModel.model.fullName)
                Divider()

                TextField("example@gmail.com", text: $viewModel.model.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                Divider()

                if isPasswordVisible {
                    TextField("Password", text: $viewModel.model.password)
                } else {
                    SecureField("Password", text: $viewModel.model.password)
                }
                Divider()

                if isConfirmPasswordVisible {
                    TextField("Confirm Password", text: $viewModel.model.confirmPassword)
                } else {
                    SecureField("Confirm Password", text: $viewModel.model.confirmPassword)
                }
                Divider()
            }

            Button {
                Task {
                    guard !viewModel.model.fullName.isEmpty,
                          !viewModel.model.email.isEmpty,
                          !viewModel.model.password.isEmpty,
                          !viewModel.model.confirmPassword.isEmpty else {
                        viewModel.errorMessage = "Please fill in all fields"
                        return
                    }

                    let success = await viewModel.register()
                    if success {
                        authVM.currentUser = UserModel(
                            fullName: viewModel.model.fullName,
                            email: viewModel.model.email
                        )
                        authVM.isAuthenticated = true
                        goToDetails = true
                    }
                }
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            NavigationLink(destination: MyDetailsView(), isActive: $goToDetails) {
                EmptyView()
            }

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

