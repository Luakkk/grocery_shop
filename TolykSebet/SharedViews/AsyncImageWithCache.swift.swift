//
//  AsyncImageWithCache.swift.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct AsyncImageWithCache: View {
    let url: URL?
    let height: CGFloat?
    let cornerRadius: CGFloat?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: height ?? 120)
        .cornerRadius(cornerRadius ?? 10)
        .clipped()
    }
}
