//
//  CategoryModel.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import Foundation

struct CategoryModel: Identifiable, Equatable {
    let id = UUID()
    let name: String         // API-название: "smartphones"
    let displayName: String // UI-название: "Smartphones"
    let imageName: String   // Название иконки или картинки
}
