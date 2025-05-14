//
//  RootView.swift
//  TolykSebet
//
//  Created by Kemel Merey on 12.05.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    @EnvironmentObject var tabSelection: TabSelection

    var body: some View {
        Group {
            if authVM.isAuthenticated {
                MainTabView()
                    .environmentObject(authVM)
                    .environmentObject(cartVM)
                    .environmentObject(favoritesVM)
                    .environmentObject(tabSelection)
            } else {
                WelcomeView()
                    .environmentObject(authVM)
                    .environmentObject(cartVM)
                    .environmentObject(favoritesVM)
                    .environmentObject(tabSelection)
            }
        }
    }
}
