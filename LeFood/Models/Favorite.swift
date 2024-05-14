//
//  Favorite.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

struct Favorite: Codable {
    let date: Date
    let itemID: String
    let kind: FeatureKind
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case itemID = "id"
        case kind = "kind"
    }
    
    init(_ item: any Feature) {
        self.date = Date()
        self.itemID = item.id
        self.kind = item.kind
    }
}

extension Favorite: Identifiable {
    var id: String {
        return "\(kind.rawValue)-\(itemID)"
    }
}
