import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [ProductModel] = []

    func toggleFavorite(_ product: ProductModel) {
        if favorites.contains(product) {
            favorites.removeAll { $0.id == product.id }
        } else {
            favorites.append(product)
        }
    }

    func isFavorite(_ product: ProductModel) -> Bool {
        favorites.contains(product)
    }
    @MainActor
    func addAllToCart(cartVM: CartViewModel) {
        for product in favorites {
            cartVM.add(product: product)
        }
    }
}


