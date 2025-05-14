//  ProductDetailView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var tabSelection: TabSelection // ✅ доступ к TabView
    @State private var showAddedAlert = false
    @EnvironmentObject var favoritesVM: FavoritesViewModel


    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 🖼 Product Image
                AsyncImage(url: URL(string: viewModel.product.imageName)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 240)
                .padding(.top)

                // Title + Brand
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.product.title)
                            .font(.title3.bold())
                        Text(viewModel.product.brand)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button {
                        favoritesVM.toggleFavorite(viewModel.product)
                    } label: {
                        Image(systemName: favoritesVM.isFavorite(viewModel.product) ? "heart.fill" : "heart")
                            .foregroundColor(favoritesVM.isFavorite(viewModel.product) ? .red : .gray)
                    }

                }
                .padding(.horizontal)

                // Quantity + Total Price
                HStack {
                    Button(action: viewModel.decrement) {
                        Image(systemName: "minus")
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }

                    Text("\(viewModel.quantity)")
                        .frame(width: 32)
                        .font(.headline)

                    Button(action: viewModel.increment) {
                        Image(systemName: "plus")
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("$\(String(format: "%.2f", viewModel.product.price * Double(viewModel.quantity)))")
                        .font(.title3.bold())
                }
                .padding(.horizontal)

                Divider()

                // Product Description
                DisclosureGroup("Product Detail") {
                    Text(viewModel.product.description)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Spacer()

                // ✅ Add To Cart Button
                Button(action: {
                    for _ in 0..<viewModel.quantity {
                        cartVM.add(product: viewModel.product)
                    }
                    showAddedAlert = true
                }) {
                    Text("Add To Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(showAddedAlert ? Color.gray : Color.green)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .scaleEffect(showAddedAlert ? 0.97 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: showAddedAlert)
                }
                .alert("✅ Added to Cart", isPresented: $showAddedAlert) {
                    Button("Go to Cart") {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            tabSelection.selectedIndex = 2
                        }
                    }
                    Button("Continue Shopping", role: .cancel) {}
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        })
        .background(Color.white.ignoresSafeArea())
    }
}
