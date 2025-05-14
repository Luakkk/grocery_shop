//
//  CartView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    @State private var showCheckoutSheet = false
    @State private var retryCheckout = false
    @State private var showFailure = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("My Cart")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .center)

                ScrollView {
                    if viewModel.items.isEmpty {
                        Text("Your cart is empty")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.items) { item in
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: item.imageURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray.opacity(0.2)
                                    }
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.headline)
                                        Text(item.subtitle)
                                            .font(.caption)
                                            .foregroundColor(.gray)

                                        HStack(spacing: 12) {
                                            Button {
                                                viewModel.decreaseQuantity(for: item)
                                            } label: {
                                                Image(systemName: "minus")
                                                    .frame(width: 24, height: 24)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(Circle())
                                            }

                                            Text("\(item.quantity)")
                                                .font(.subheadline)

                                            Button {
                                                viewModel.increaseQuantity(for: item)
                                            } label: {
                                                Image(systemName: "plus")
                                                    .frame(width: 24, height: 24)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        Text("$\(String(format: "%.2f", item.price))")
                                            .fontWeight(.bold)

                                        Button {
                                            viewModel.removeItem(item)
                                        } label: {
                                            Image(systemName: "xmark")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                        .animation(.default, value: viewModel.items) // ✅ Анимация
                    }
                }

                // Кнопка перехода к оформлению
                if !viewModel.items.isEmpty {
                    Button {
                        showCheckoutSheet = true
                    } label: {
                        HStack {
                            Text("Go to Checkout")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("$\(String(format: "%.2f", viewModel.totalPrice))")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color(red: 0.43, green: 0.75, blue: 0.45))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }

                    .sheet(isPresented: $showCheckoutSheet) {
                        CheckoutSheetView(isPresented: $showCheckoutSheet, retryCheckout: $retryCheckout)
                            .environmentObject(viewModel)
                    }


                    .sheet(isPresented: $showFailure) {
                        OrderFailedView(retryCheckout: $retryCheckout)
                    }

                    // при retryCheckout = true снова показать Checkout
                    .onChange(of: retryCheckout) { newValue in
                        if newValue {
                            showCheckoutSheet = true
                            retryCheckout = false
                        }
                    }
                }
            }
        }
    }
}
