//
//  ProductModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

struct ProductModel: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let rating: Double
    let brand: String
    let category: String

    // Маппинг для UI
    var displayWeight: String {
        return "1kg"
    }

    var nutritionInfo: String {
        return "100gr"
    }

    var imageName: String {
        return thumbnail
    }

    var displayRating: Int {
        return Int(rating.rounded())
    }
}
