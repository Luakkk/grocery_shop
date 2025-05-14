//
//  CityPickerView.swift
//  TolykSebet
//
//  Created by Kemel Merey on 12.05.2025.
//

import SwiftUI

struct CityPickerView: View {
    let country: String
    @Binding var selectedCity: String
    @Environment(\.dismiss) var dismiss

    @State private var cities: [String] = []
    @State private var searchText: String = ""
    @State private var isLoading = true
    @State private var errorMessage: String?

    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 🔍 Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search city", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

                if isLoading {
                    ProgressView("Loading cities...")
                        .padding()
                } else if let error = errorMessage {
                    Text("❌ \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(filteredCities, id: \.self) { city in
                        Button {
                            selectedCity = city
                            dismiss()
                        } label: {
                            Text(city)
                                .padding(.vertical, 6)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Select City")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await loadCities()
            }
        }
    }

    // MARK: - Load cities from API
    func loadCities() async {
        do {
            cities = try await CityAPIService.shared.fetchCities(for: country)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
