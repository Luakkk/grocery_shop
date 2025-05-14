//
//  StoreHomeViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

@MainActor
class StoreHomeViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var categories: [CategoryModel] = []

    init() {
        Task {
            await loadData()
        }
    }

    func loadData() async {
        do {
            // Загружаем продукты
            products = try await ProductApiService.shared.fetchAllProducts(limit: 10)

            // Загружаем категории и конвертируем в CategoryModel
            let raw = try await ProductApiService.shared.fetchCategories()
            self.categories = mapCategories(raw)
        } catch {
            print("❌ Error loading data: \(error)")
        }
    }

    private func mapCategories(_ raw: [String]) -> [CategoryModel] {
        let knownIcons: [String: String] = [
            "smartphones": "iphone",
            "laptops": "laptopcomputer",
            "fragrances": "drop.fill",
            "skincare": "face.smiling",
            "groceries": "cart.fill",
            "home-decoration": "house.fill",
            "furniture": "bed.double.fill",
            "tops": "tshirt",
            "womens-dresses": "figure.dress.line.vertical.figure",
            "mens-shirts": "tshirt.fill"
        ]

        return raw.map { name in
            CategoryModel(
                name: name,
                displayName: name.replacingOccurrences(of: "-", with: " ").capitalized,
                imageName: knownIcons[name] ?? "tag"
            )
        }
    }
}
