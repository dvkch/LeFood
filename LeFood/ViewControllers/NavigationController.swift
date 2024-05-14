//
//  NavigationController.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers.first?.loadViewIfNeeded()

        navigationBar.standardAppearance.configureWithDefaultBackground()
        navigationBar.standardAppearance.backgroundColor = .backgroundAlt
        navigationBar.standardAppearance.shadowColor = nil
        
        #if targetEnvironment(macCatalyst)
        navigationBar.prefersLargeTitles = true
        #endif
        
        navigationBar.standardAppearance.titleTextAttributes[.foregroundColor] = UIColor.text
        navigationBar.standardAppearance.largeTitleTextAttributes[.foregroundColor] = UIColor.text
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.compactAppearance = navigationBar.standardAppearance
        navigationBar.compactScrollEdgeAppearance = navigationBar.standardAppearance
    }
}
