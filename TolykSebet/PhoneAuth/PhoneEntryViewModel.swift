import SwiftUI
import FirebaseAuth

@MainActor
class PhoneEntryViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var selectedCountry = CountryModel(name: "Kazakhstan", code: "KZ", dial_code: "+7", flag: "🇰🇿")
    @Published var countries: [CountryModel] = []
    @Published var showCountryPicker = false
    @Published var navigateToVerification = false
    @Published var verificationID: String?

    init() {
        Task {
            await loadCountries()
        }
    }

    func loadCountries() async {
        do {
            countries = try await CountryAPIService.shared.fetchCountries()
        } catch {
            print("❌ Failed to fetch countries: \(error)")
        }
    }

    func updateCountryFromInput() {
        if let match = countries.first(where: { phoneNumber.hasPrefix($0.dial_code.replacingOccurrences(of: "+", with: "")) }) {
            selectedCountry = match
        }
    }

    func sendCode() {
        let fullNumber = selectedCountry.dial_code + phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(fullNumber, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let verificationID = verificationID else {
                print("❌ Error: verificationID is nil")
                return
            }

            self?.verificationID = verificationID
            self?.navigateToVerification = true
        }
    }

}
