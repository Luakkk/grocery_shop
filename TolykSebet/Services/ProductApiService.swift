//
//  ProductApiService.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

final class ProductApiService {
    static let shared = ProductApiService()
    private init() {}

    private let baseURL = "https://dummyjson.com"

    // MARK: - Fetch All Products
    func fetchAllProducts(limit: Int = 20) async throws -> [ProductModel] {
        let url = URL(string: "\(baseURL)/products?limit=\(limit)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(ProductListResponse.self, from: data)
        return decoded.products
    }

    // MARK: - Fetch Product by ID
    func fetchProduct(id: Int) async throws -> ProductModel {
        let url = URL(string: "\(baseURL)/products/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ProductModel.self, from: data)
    }

    // MARK: - Fetch Products by Category
    func fetchProducts(by category: String) async throws -> [ProductModel] {
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? category
        let url = URL(string: "\(baseURL)/products/category/\(encodedCategory)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(ProductListResponse.self, from: data)
        return decoded.products
    }
    
    // MARK: - Search Products
    func searchProducts(query: String) async throws -> [ProductModel] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/products/search?q=\(encodedQuery)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(ProductListResponse.self, from: data)
        return decoded.products
    }
    // ✅ MARK: - Fetch All Categories (array of strings)
    func fetchCategories() async throws -> [String] {
        let url = URL(string: "\(baseURL)/products/categories")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
}

// MARK: - Response Wrapper
struct ProductListResponse: Codable {
    let products: [ProductModel]
}
