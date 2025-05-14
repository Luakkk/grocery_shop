import SwiftUI

struct StoreHomeView: View {
    @StateObject private var viewModel = StoreHomeViewModel()
    @AppStorage("selectedCity") private var selectedCity = "Almaty"
    @State private var showCityPicker = false

    @EnvironmentObject var tabSelection: TabSelection
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    locationAndSearchSection
                    productGridSection
                    Spacer(minLength: 60)
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Location + Search
    private var locationAndSearchSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Delivery to")
                .font(.caption)
                .foregroundColor(.gray)

            HStack {
                Text("\(selectedCity), Kazakhstan")
                    .font(.title3)
                    .bold()
                Spacer()
                Button {
                    showCityPicker = true
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            TextField("Search for items", text: .constant(""))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showCityPicker) {
            CityPickerView(country: "Kazakhstan", selectedCity: $selectedCity)
        }
    }

    // MARK: - Product Grid
    private var productGridSection: some View {
        VStack(alignment: .leading) {
            Text("List of Products")
                .font(.title3)
                .bold()
                .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.products) { product in
                    NavigationLink {
                        ProductDetailView(viewModel: ProductDetailViewModel(product: product))
                            .environmentObject(tabSelection) // 👈 обязательно передаём!
                    } label: {
                        productCard(for: product)
                    }

                }
            }
            .padding(.horizontal)
        }
    }

    private func productCard(for product: ProductModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImageWithCache(
                url: URL(string: product.thumbnail),
                height: 120,
                cornerRadius: 10
            )

            Text(product.title)
                .font(.body)
                .fontWeight(.medium)
                .lineLimit(1)

            Text(product.brand)
                .font(.caption)
                .foregroundColor(.gray)

            Text("$\(String(format: "%.2f", product.price))")
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

