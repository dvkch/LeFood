//
//  UIColor+SY.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

extension UIColor {
    static var accent: UIColor? {
        var color: UIColor?
        #if targetEnvironment(macCatalyst)
        color = UIColor.value(forKey: "controlAccentColor") as? UIColor
        #endif
        return color ?? systemPurple
    }

    static var background: UIColor {
        return .init(light: .init(white: 0.96, alpha: 1), dark: .init(white: 0.16, alpha: 1))
    }
    
    static var backgroundAlt: UIColor {
        return .init(light: .init(white: 0.86, alpha: 1), dark: .init(white: 0.1, alpha: 1))
    }
    
    static var text: UIColor {
        return .label
    }
    
    static var textAlt: UIColor {
        return .secondaryLabel
    }
    
    private convenience init(light: UIColor, dark: UIColor) {
        self.init { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        }
    }
}
