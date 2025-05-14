import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct MyDetailsView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var phoneNumber: String = ""
    @State private var quickPassword: String = ""
    @State private var countryName: String = ""
    @State private var goToStore = false
    @State private var errorMessage: String?

    // Пример справочника стран по dial_code
    let countryCodes: [String: String] = [
        "+1": "United States",
        "+7": "Kazakhstan",
        "+44": "United Kingdom",
        "+91": "India",
        "+81": "Japan"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Welcome, \(authVM.currentUser?.fullName ?? "")")) {
                    Text(authVM.currentUser?.email ?? "")
                }

                Section(header: Text("Phone Number")) {
                    TextField("Enter phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .onChange(of: phoneNumber) { _ in
                            detectCountryFromPhone()
                        }
                }

                Section(header: Text("Country (auto-detected)")) {
                    Text(countryName.isEmpty ? "Unknown" : countryName)
                }

                Section(header: Text("6-digit Quick Password")) {
                    SecureField("Enter quick access code", text: $quickPassword)
                        .keyboardType(.numberPad)
                }

                Button("Save and Continue") {
                    validateAndSave()
                }

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                NavigationLink(destination: StoreHomeView(), isActive: $goToStore) {
                    EmptyView()
                }
            }
            .navigationTitle("My Details")
            .onAppear {
                phoneNumber = authVM.currentUser?.phoneNumber ?? ""
                quickPassword = authVM.currentUser?.quickPassword ?? ""
                detectCountryFromPhone()
            }
        }
    }

    private func detectCountryFromPhone() {
        // Пример: +77011234567 → "+7"
        let trimmed = phoneNumber.trimmingCharacters(in: .whitespaces)
        for (prefix, name) in countryCodes {
            if trimmed.hasPrefix(prefix) {
                countryName = name
                return
            }
        }
        countryName = "Unknown"
    }

    private func validateAndSave() {
        guard !phoneNumber.isEmpty else {
            errorMessage = "Phone number is required"
            return
        }

        guard quickPassword.count == 6, quickPassword.allSatisfy({ $0.isNumber }) else {
            errorMessage = "Quick password must be exactly 6 digits"
            return
        }

        saveUserData()
    }

    private func saveUserData() {
        guard let user = authVM.currentUser,
              let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }

        let userData: [String: Any] = [
            "uid": uid,
            "fullName": user.fullName,
            "email": user.email,
            "phoneNumber": phoneNumber,
            "quickPassword": quickPassword,
            "country": countryName
        ]

        let db = Firestore.firestore()
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                self.errorMessage = "Failed to save: \(error.localizedDescription)"
            } else {
                authVM.currentUser?.phoneNumber = phoneNumber
                authVM.currentUser?.quickPassword = quickPassword
                goToStore = true
            }
        }
    }
}

