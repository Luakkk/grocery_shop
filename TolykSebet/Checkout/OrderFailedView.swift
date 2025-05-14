//
//  OrderFailedView.swift
//  TolykSebet
//
//  Created by Kemel Merey on 13.05.2025.
//

import SwiftUI

struct OrderFailedView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var retryCheckout: Bool // 📌 для повторного показа Checkout

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image("order_image") // 🛍 добавь ассет
                .resizable()
                .frame(width: 140, height: 140)

            Text("Oops! Order Failed")
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text("Something went wrong. Please check your order details.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    retryCheckout = true // 📌 показываем снова Checkout
                }
            } label: {
                Text("Please Try Again")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Button {
                dismiss()
            } label: {
                Text("Back to home")
                    .font(.headline)
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding()
    }
}

