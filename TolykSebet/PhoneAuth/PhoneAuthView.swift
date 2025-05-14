import SwiftUI

struct PhoneAuthView: View {
    @StateObject private var viewModel = PhoneAuthViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState private var isPhoneFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }
                    Spacer()
                }
                .padding(.top, 12)
                .padding(.horizontal)

                // Title
                Text("Enter your mobile number")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Label
                Text("Mobile Number")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Input Field
                HStack(spacing: 12) {
                    Button {
                        viewModel.showCountryPicker = true
                    } label: {
                        Text(viewModel.selectedCountry.flag)
                            .font(.system(size: 24))
                    }

                    Text(viewModel.selectedCountry.dial_code)
                        .font(.body)
                        .bold()

                    TextField("Phone number", text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .focused($isPhoneFocused)
                        .onChange(of: viewModel.phoneNumber) { _ in
                            viewModel.updateCountryFromInput()
                        }
                        .textContentType(.telephoneNumber)
                        .font(.body)
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                // Error Message
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()

                // Next Button
                Button {
                    viewModel.sendCode()
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color(red: 0.43, green: 0.75, blue: 0.45)))
                }
                .disabled(viewModel.phoneNumber.isEmpty)
                .opacity(viewModel.phoneNumber.isEmpty ? 0.3 : 1)

                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    isPhoneFocused = true
                }
            }
            .sheet(isPresented: $viewModel.showCountryPicker) {
                NavigationView {
                    CountryPickerView(
                        selectedCountry: $viewModel.selectedCountry,
                        countries: viewModel.countries
                    )
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToVerification) {
                VerificationView(
                    verificationID: viewModel.verificationID ?? "",
                    phoneNumber: viewModel.selectedCountry.dial_code + viewModel.phoneNumber
                )
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}



