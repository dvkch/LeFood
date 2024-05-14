//
//  UIImage+SY.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

extension UIImage {
    enum Icon: String {
        case bookmark       = "bookmark"
        case bookmarkSlash  = "bookmark.slash"
        case bookmarkFill   = "bookmark.fill"
        case checkcmark     = "checkmark"
        case right          = "chevron.right"
        case gear           = "gear"
        case loupe          = "magnifyingglass"
        case map            = "map"
        case mapFill        = "map.fill"
        case share          = "square.and.arrow.up"
        case trash          = "trash"
        case close          = "xmark"

        var availableVariantsCount: Int {
            switch self {
            case .close:    return  4
            default:        return  1
            }
        }
        
        func assetName(variant: Int?) -> String {
            guard availableVariantsCount > 1 else { return rawValue }
            let boundedVariant: Int
            if let variant {
                boundedVariant = variant % availableVariantsCount
            }
            else {
                boundedVariant = Int.random(in: 0..<availableVariantsCount)
            }
            return "\(rawValue).\(boundedVariant)"
        }
    }

    static func icon(_ icon: Icon?, variant: Int? = 0, useSystem: Bool = false) -> UIImage? {
        guard let icon else { return nil }

        if useSystem {
            return UIImage(systemName: icon.rawValue)
        }

        return UIImage(named: icon.assetName(variant: variant))
    }
}
