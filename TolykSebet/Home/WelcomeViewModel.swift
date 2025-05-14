import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    @Published var countries: [CountryModel] = []
    @Published var selectedCountry = CountryModel(
        name: "Kazakhstan",
        code: "KZ",
        dial_code: "+7",
        flag: "🇰🇿"
    )


    init() {
        Task {
            await fetchCountries()
        }
    }

    @MainActor
    func fetchCountries() async {
        do {
            let result = try await CountryAPIService.shared.fetchCountries()
            self.countries = result

            if let kaz = result.first(where: { $0.code == "KZ" || $0.dial_code == "+7" }) {
                self.selectedCountry = kaz
            }
        } catch {
            print("❌ Failed to fetch countries: \(error)")
        }
    }
}



