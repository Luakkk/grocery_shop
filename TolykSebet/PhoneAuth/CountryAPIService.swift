import Foundation

class CountryAPIService {
    static let shared = CountryAPIService()
    private init() {}

    func fetchCountries() async throws -> [CountryModel] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            throw NSError(domain: "CountryAPIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "countries.json not found"])
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([CountryModel].self, from: data)
    }
}




