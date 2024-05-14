//
//  TabController.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

class TabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach { $0.loadViewIfNeeded() }
        tabBar.standardAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance.backgroundColor = .backgroundAlt
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}
