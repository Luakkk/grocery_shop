//
//  ExploreViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var productsByCategory: [String: [ProductModel]] = [:]
    @Published var isLoading: Bool = false

    init() {
        Task {
            await loadCategories()
        }
    }

    func loadCategories() async {
        isLoading = true
        do {
            let categoryNames = try await ProductApiService.shared.fetchCategories()

            // Маппим в CategoryModel для отображения
            self.categories = categoryNames.map {
                CategoryModel(name: $0, displayName: $0.capitalized, imageName: "category_\($0)")
            }

        } catch {
            print("❌ Failed to load categories: \(error)")
        }
        isLoading = false
    }

    func loadProducts(for category: CategoryModel) async {
        guard productsByCategory[category.name] == nil else { return } // Кэш

        do {
            let products = try await ProductApiService.shared.fetchProducts(by: category.name)
            productsByCategory[category.name] = products
        } catch {
            print("❌ Failed to load products for \(category.name): \(error)")
        }
    }

    func products(for category: CategoryModel) -> [ProductModel] {
        return productsByCategory[category.name] ?? []
    }
}
