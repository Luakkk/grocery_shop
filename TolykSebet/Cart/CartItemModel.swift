//
//  CartItemModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

struct CartItemModel: Identifiable, Equatable, Codable {
    let id: UUID
    let productID: Int
    let title: String
    let subtitle: String
    let imageURL: String
    let price: Double
    var quantity: Int

    init(product: ProductModel) {
        self.id = UUID() // ← вот UUID, теперь он будет найден
        self.productID = product.id
        self.title = product.title
        self.subtitle = product.brand + ", " + product.category
        self.imageURL = product.thumbnail
        self.price = product.price
        self.quantity = 1
    }
}
