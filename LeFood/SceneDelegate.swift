//
//  SceneDelegate.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let tabController = TabController()
    private let mapVC = MapVC()
    private let favoritesVC = FavoritesVC()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        windowScene.sizeRestrictions?.minimumSize = .init(width: 800, height: 550)
        // TODO: tabController.additionalSafeAreaInsets = .init(top: 16, left: 12, bottom: 12, right: 12)
        #endif

        let mapNC = NavigationController(rootViewController: mapVC)
        mapNC.tabBarItem.title = L10n.Map.title
        mapNC.tabBarItem.image = .icon(.map)
        mapNC.tabBarItem.selectedImage = .icon(.mapFill)

        let favoriteNC = NavigationController(rootViewController: favoritesVC)
        favoriteNC.tabBarItem.title = L10n.Favorites.title
        favoriteNC.tabBarItem.image = .icon(.bookmark)
        favoriteNC.tabBarItem.selectedImage = .icon(.bookmarkFill)

        tabController.viewControllers = [mapNC, favoriteNC]

        window = UIWindow(windowScene: windowScene)
        window?.tintColor = .accent
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        Snapshot.setupSnapshots {
            window?.overrideUserInterfaceStyle = $0.mockInterfaceStyle
        }
        
        (UIApplication.shared.delegate as! AppDelegate).window = window
    }
}

