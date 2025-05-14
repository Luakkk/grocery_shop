import SwiftUI

struct PhoneEntryView: View {
    @StateObject private var viewModel = PhoneEntryViewModel()
    @FocusState private var isInputFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Spacer()
                }

                Text("Enter your mobile number")
                    .font(.title2)
                    .fontWeight(.bold)

                HStack {
                    Button {
                        viewModel.showCountryPicker = true
                    } label: {
                        Text(viewModel.selectedCountry.flag)
                            .font(.title2)
                    }

                    Text(viewModel.selectedCountry.dial_code)
                        .font(.body)
                        .bold()

                    TextField("Phone number", text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .focused($isInputFocused)
                        .onChange(of: viewModel.phoneNumber) { _ in
                            viewModel.updateCountryFromInput()
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                Button {
                    viewModel.sendCode()
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.green))
                }

                Spacer()
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isInputFocused = true
                }
            }
            .sheet(isPresented: $viewModel.showCountryPicker) {
                CountryPickerView(
                    selectedCountry: $viewModel.selectedCountry,
                    countries: viewModel.countries
                )
            }
            .navigationDestination(isPresented: $viewModel.navigateToVerification) {
                VerificationView(
                    verificationID: viewModel.verificationID ?? "",
                    phoneNumber: viewModel.selectedCountry.dial_code + viewModel.phoneNumber
                )

            }
        }
    }
}

