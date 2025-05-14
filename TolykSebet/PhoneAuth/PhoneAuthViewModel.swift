import Foundation
import FirebaseAuth

@MainActor
class PhoneAuthViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var selectedCountry = CountryModel(name: "Kazakhstan", code: "KZ", dial_code: "+7", flag: "🇰🇿")
    @Published var countries: [CountryModel] = []
    @Published var showCountryPicker = false
    @Published var verificationID: String?
    @Published var navigateToVerification = false
//    @Published var errorMessage: String?
    @Published var errorMessage: String? = nil

    init() {
        Task {
            await loadCountries()
        }
    }

    func loadCountries() async {
        do {
            countries = try await CountryAPIService.shared.fetchCountries()
        } catch {
            errorMessage = "❌ Failed to fetch countries"
        }
    }

    func updateCountryFromInput() {
        if let match = countries.first(where: {
            phoneNumber.hasPrefix($0.dial_code.replacingOccurrences(of: "+", with: ""))
        }) {
            selectedCountry = match
        }
    }

    func sendCode() {
        let fullNumber = selectedCountry.dial_code + phoneNumber.trimmingCharacters(in: .whitespaces)

        guard !phoneNumber.isEmpty else {
            errorMessage = "⚠️ Enter phone number"
            return
        }

        #if targetEnvironment(simulator)
        self.verificationID = "SIMULATOR_MOCK_VERIFICATION"
        self.navigateToVerification = true
        #else
        PhoneAuthProvider.provider().verifyPhoneNumber(fullNumber, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                self?.errorMessage = "❌ \(error.localizedDescription)"
                return
            }

            guard let verificationID = verificationID else {
                self?.errorMessage = "❌ verificationID is nil"
                return
            }

            self?.verificationID = verificationID
            self?.navigateToVerification = true
        }
        #endif
    }
}
