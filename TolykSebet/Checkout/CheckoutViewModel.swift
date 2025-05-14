//
//  CheckoutViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

class CheckoutViewModel: ObservableObject {
    @Published var options: [CheckoutOption] = [
        CheckoutOption(type: .delivery, value: "Select Method"),
        CheckoutOption(type: .payment, value: "Select Payment"),
        CheckoutOption(type: .promoCode, value: "Pick discount")
    ]

    @Published var totalCost: Double = 0.0
    @Published var orderPlaced: Bool = false
    @Published var orderFailed: Bool = false

    func update(option type: CheckoutOptionType, with newValue: String) {
        if let index = options.firstIndex(where: { $0.type == type }) {
            options[index].value = newValue
        }
    }

    func placeOrder() {
        // Симуляция случайного успеха или ошибки
        let success = Bool.random()
        print("🧾 Order placed with: \(options)")

        if success {
            orderPlaced = true
        } else {
            orderFailed = true
        }
    }

    // Для сброса состояния (если нужно)
    func reset() {
        orderPlaced = false
        orderFailed = false
    }

    // Выводы значений опций для отображения
    var selectedDelivery: String {
        options.first(where: { $0.type == .delivery })?.value ?? ""
    }

    var selectedPayment: String {
        options.first(where: { $0.type == .payment })?.value ?? ""
    }

    var promoCode: String {
        options.first(where: { $0.type == .promoCode })?.value ?? ""
    }
}
