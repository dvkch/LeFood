//
//  ProducerProperties.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

struct ProducerProperties: Codable {
    let name: String
    let addressStreet: String
    let addressZipCode: String
    let addressCity: String
    let kind: String
    let produces: [String]
    let producesOrigin: String
    let updateDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name           = "nom"
        case addressStreet  = "adresse"
        case addressZipCode = "insee"
        case addressCity    = "commune"
        case kind           = "type"
        case produces       = "produits"
        case producesOrigin = "origine_produits"
        case updateDate     = "datemaj"
    }
}

extension ProducerProperties: FeatureProperties {
    var details: String {
        return [fullAddress, kind, produces.joined(separator: ", "), producesOrigin].joined(separator: "\n")
    }
}
