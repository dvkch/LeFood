//
//  Preferences.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation
import Shush

extension Notification.Name {
    static let favoritesChanged = Notification.Name("favoritesChanged")
}

class Preferences {
    
    // MARK: Init
    static let shared = Preferences()
    private init() {}
    
    // MARK: Properties
    @ShushValues(prefix: "favorite-", sortedBy: \.date, order: .asc, ubiquitous: .default, notification: .favoritesChanged)
    var favorites: [Favorite]
    
    func mark(_ item: any Feature, favorited: Bool) {
        if favorited {
            _favorites.insert(.init(item))
        }
        else {
            _favorites.remove(.init(item))
        }
    }
    func isItemFavorited(_ item: any Feature) -> Bool {
        return favorites.contains(where: { $0.itemID == item.id && $0.kind == item.kind })
    }

    @ShushValue(key: "cached_markets", defaultValue: .init(), ubiquitous: nil)
    var cachedMarkets: Page<Market>

    @ShushValue(key: "cached_producers", defaultValue: .init(), ubiquitous: nil)
    var cachedProducers: Page<Producer>
}
