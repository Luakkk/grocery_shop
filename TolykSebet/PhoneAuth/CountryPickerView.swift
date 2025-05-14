import SwiftUI

struct CountryPickerView: View {
    @Binding var selectedCountry: CountryModel
    var countries: [CountryModel]
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""

    var filteredCountries: [CountryModel] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.dial_code.contains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // 🔍 Styled search field
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search by country or code", text: $searchText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()

            // 📃 Filtered list
            List(filteredCountries) { country in
                Button {
                    selectedCountry = country
                    dismiss()
                } label: {
                    HStack {
                        Text(country.flag)
                            .font(.title2)
                        Text(country.name)
                        Spacer()
                        Text(country.dial_code)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Select Country")
        .navigationBarTitleDisplayMode(.inline)
    }
}
