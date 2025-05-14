//
//  ProductDetailViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductModel
    @Published var quantity: Int = 1

    init(product: ProductModel) {
        self.product = product
    }

    func increment() {
        quantity += 1
    }

    func decrement() {
        if quantity > 1 {
            quantity -= 1
        }
    }
}
