import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var showPhoneAuth = false
    @State private var showEmailLogin = false
    @State private var showEmailSignup = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image("welcome_header")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipped()
                    .ignoresSafeArea(edges: .top)

                Text("Get your groceries\nwith TolykSebet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Button {
                    showPhoneAuth = true
                } label: {
                    HStack(spacing: 10) {
                        Text(viewModel.selectedCountry.flag)
                            .font(.title2)
                        Text(viewModel.selectedCountry.dial_code)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                Divider().padding(.horizontal)

                Text("Or connect with social media")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Button {
                    showEmailLogin = true
                } label: {
                    Text("Continue with Email Sign In")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal)

                Button {
                    showEmailSignup = true
                } label: {
                    Text("Continue with Email Sign Up")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .navigationDestination(isPresented: $showPhoneAuth) {
                PhoneAuthView()
            }
            .navigationDestination(isPresented: $showEmailLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $showEmailSignup) {
                NavigationStack {
                    SignUpView()
                }
            }
        }
    }
}
