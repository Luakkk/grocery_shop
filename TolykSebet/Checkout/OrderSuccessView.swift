//
//  OrderSuccessView.swift
//  TolykSebet
//
//  Created by Kemel Merey on 12.05.2025.
//
import SwiftUI

struct OrderSuccessView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)

            Text("Your Order has been accepted")
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text("Your items have been placed and are on their way to being processed.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button {
                dismiss() // или navigate to HomeView
            } label: {
                Text("Back to home")
                    .font(.headline)
                    .foregroundColor(.black)
            }

            Spacer(minLength: 24)
        }
        .padding()
    }
}

