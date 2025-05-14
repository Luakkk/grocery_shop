import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: FavoritesViewModel
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack(spacing: 0) {
            Text("Favourites")
                .font(.system(size: 20, weight: .semibold))
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)

            if viewModel.favorites.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray.opacity(0.3))
                    Text("No favourites yet")
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.favorites) { item in
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: item.thumbnail)) { image in
                                    image.resizable().aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.body)
                                        .fontWeight(.medium)
                                    Text(item.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }

                                Spacer()

                                Text("$\(String(format: "%.2f", item.price))")
                                    .font(.body)
                                    .fontWeight(.semibold)

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }

                Button(action: {
                    viewModel.addAllToCart(cartVM: cartVM)
                }) {
                    Text("Add All To Cart")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.green)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

