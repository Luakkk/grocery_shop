//
//  CategoryProductListView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct CategoryProductListView: View {
    let category: CategoryModel
    let products: [ProductModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(category.displayName)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(products) { product in
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color(.systemGray5)
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                    .font(.body)
                                    .bold()

                                Text(product.brand)
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                Text("$\(String(format: "%.2f", product.price))")
                                    .font(.subheadline)
                                    .bold()
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle(category.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
