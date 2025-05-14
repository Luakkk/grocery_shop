//
//  ExploreView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var selectedCategory: CategoryModel? = nil
    @State private var navigateToCategory = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Заголовок
                Text("Find Products")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Поисковая строка
                TextField("Search Store", text: .constant(""))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // Сетка категорий
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.categories) { category in
                        Button {
                            selectedCategory = category
                            navigateToCategory = true
                        } label: {
                            VStack(spacing: 8) {
                                Image(category.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .padding()

                                Text(category.displayName)
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }

            // 🧠 Навигация в продукты категории
            .navigationDestination(isPresented: $navigateToCategory) {
                if let category = selectedCategory {
                    CategoryProductListView(
                        category: category,
                        products: viewModel.products(for: category)
                    )
                    .task {
                        await viewModel.loadProducts(for: category)
                    }
                }
            }
        }
    }
}
