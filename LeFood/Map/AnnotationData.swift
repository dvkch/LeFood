//
//  AnnotationData.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

struct AnnotationData {
    let feature: any Feature
    let favorited: Bool
    
    init(feature: any Feature, favorited: Bool) {
        self.feature = feature
        self.favorited = favorited
    }
}

extension AnnotationData: Equatable, Identifiable {
    static func ==(lhs: AnnotationData, rhs: AnnotationData) -> Bool {
        return lhs.feature.id == rhs.feature.id && lhs.feature.kind == rhs.feature.kind && lhs.favorited == rhs.favorited
    }
    
    var id: String {
        return "\(feature.kind.rawValue)-\(feature.id)"
    }
}

extension AnnotationData {
    static func buildData(markets: [Market], producers: [Producer], favorites: [Favorite]) -> [AnnotationData] {
        let favoritedMarkets = Set(favorites.filter { $0.kind == .market }.map(\.itemID))
        let favoritedProducers = Set(favorites.filter { $0.kind == .producer }.map(\.itemID))

        let markets = Preferences.shared.cachedMarkets.features.map {
            AnnotationData(feature: $0, favorited: favoritedMarkets.contains($0.id))
        }
        let producers = Preferences.shared.cachedProducers.features.map {
            AnnotationData(feature: $0, favorited: favoritedProducers.contains($0.id))
        }
        return markets + producers
    }
}
