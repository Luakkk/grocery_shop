//
//  CartViewModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    static let shared = CartViewModel() // ✅ Singleton для глобального доступа

    @Published var items: [CartItemModel] = [] {
        didSet {
            saveCart()
        }
    }

    private let cartKey = "saved_cart"

    private init() { // ✅ Закрыли внешний доступ
        loadCart()
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }

    func add(product: ProductModel) {
        if let index = items.firstIndex(where: { $0.productID == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItemModel(product: product))
        }
    }

    func removeItem(_ item: CartItemModel) {
        items.removeAll { $0.id == item.id }
    }

    func increaseQuantity(for item: CartItemModel) {
        guard let index = items.firstIndex(of: item) else { return }
        items[index].quantity += 1
    }

    func decreaseQuantity(for item: CartItemModel) {
        guard let index = items.firstIndex(of: item) else { return }
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        }
    }

    func clearCart() {
        items.removeAll()
    }

    func contains(product: ProductModel) -> Bool {
        items.contains { $0.productID == product.id }
    }

    private func saveCart() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: cartKey)
        }
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey),
              let decoded = try? JSONDecoder().decode([CartItemModel].self, from: data) else { return }
        self.items = decoded
    }
}
