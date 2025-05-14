//
//  MainTabView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var cartVM = CartViewModel.shared
    @StateObject var tabSelection = TabSelection()

    var body: some View {
        TabView(selection: $tabSelection.selectedIndex) {
            StoreHomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Shop")
                }
                .tag(0)

    

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(2)

            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favourite")
                }
                .tag(3)

            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(4)
        }
        .tint(Color(red: 0.43, green: 0.75, blue: 0.45))
        .environmentObject(cartVM)
        .environmentObject(tabSelection) // ✅ Прокидываем TabSelection
    }
}
