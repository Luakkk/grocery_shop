//
//  SearchViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [ProductModel] = []

    func searchProducts() async {
        guard !query.isEmpty else {
            results = []
            return
        }

        do {
            let allProducts = try await ProductApiService.shared.fetchAllProducts(limit: 100)
            results = allProducts.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.brand.lowercased().contains(query.lowercased()) ||
                $0.category.lowercased().contains(query.lowercased())
            }
        } catch {
            print("❌ Search error: \(error)")
        }
    }

    func addToCart(_ product: ProductModel, cartVM: CartViewModel) {
        cartVM.add(product: product)
    }
}
