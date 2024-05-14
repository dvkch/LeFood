//
//  MarketProperties.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

struct MarketProperties: Codable {
    let addressStreet: String
    let addressZipCode: String
    let addressCity: String
    let kind: Kind
    var openings: [MarketOpening]
    
    enum Kind: String, Codable {
        case food = "alimentaire"
        case mixed = "mixte"
    }
    
    private enum CodingKeys: String, CodingKey {
        case addressStreet  = "adresse"
        case addressZipCode = "insee"
        case addressCity    = "commune"
        case kind           = "type"
        case openings       = "horaires"
    }
}

extension MarketProperties: FeatureProperties {
    var name: String {
        return "Marché \(addressStreet)"
    }
    
    var details: String {
        return ([fullAddress] + openings.sorted().map(\.description)).joined(separator: "\n")
    }
}
