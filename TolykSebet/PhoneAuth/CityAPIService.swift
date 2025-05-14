//
//  CityAPIService.swift
//  TolykSebet
//
//  Created by Kemel Merey on 12.05.2025.
//

import Foundation

class CityAPIService {
    static let shared = CityAPIService()

    func fetchCities(for country: String) async throws -> [String] {
        guard let url = URL(string: "https://countriesnow.space/api/v0.1/countries/cities") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["country": country]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(CityListResponse.self, from: data)
        return decoded.data
    }
}

struct CityListResponse: Codable {
    let error: Bool
    let msg: String
    let data: [String]
}
