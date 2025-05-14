//
//  SceneDelegate.swift
//  TolykSebet
//
//  Created by Kemel Merey on 10.05.2025.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        // ✅ Создаём глобальные объекты
        let authVM = AuthViewModel()
        let cartVM = CartViewModel.shared
        let favoritesVM = FavoritesViewModel()
        let tabSelection = TabSelection()

        // ✅ RootView автоматически покажет нужный экран
        let rootView = RootView()
            .environmentObject(authVM)
            .environmentObject(cartVM)
            .environmentObject(favoritesVM)
            .environmentObject(tabSelection)

        let hostingController = UIHostingController(rootView: rootView)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = hostingController
        self.window = window
        window.makeKeyAndVisible()
    }
}
