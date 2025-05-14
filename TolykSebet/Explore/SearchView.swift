//
//  SearchView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isFocused: Bool
    @EnvironmentObject var cartVM: CartViewModel // ✅ получаем cartVM здесь

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // 🔍 Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search", text: $viewModel.query)
                        .focused($isFocused)
                        .onSubmit {
                            Task {
                                await viewModel.searchProducts()
                            }
                        }

                    if !viewModel.query.isEmpty {
                        Button(action: {
                            viewModel.query = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                // 🧾 Grid of Results
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.results) { product in
                            VStack(spacing: 8) {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(height: 100)
                                .cornerRadius(12)

                                Text(product.title)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)

                                Text("\(product.brand), \(product.category)")
                                    .font(.caption2)
                                    .foregroundColor(.gray)

                                Text("$\(String(format: "%.2f", product.price))")
                                    .font(.subheadline)
                                    .bold()

                                Button {
                                    viewModel.addToCart(product, cartVM: cartVM) // ✅ передаём cartVM
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(Color.green)
                                        .clipShape(Circle())
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 3)
                        }
                    }
                    .padding()
                }

                Spacer(minLength: 60)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFocused = true
            }
        }
    }
}
