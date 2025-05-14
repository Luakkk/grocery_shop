//
//  CheckoutOption.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

enum CheckoutOptionType: String, CaseIterable {
    case delivery = "Delivery"
    case payment = "Payment"
    case promoCode = "Promo Code"
}

struct CheckoutOption: Identifiable {
    let id = UUID()
    let type: CheckoutOptionType
    var value: String
}
