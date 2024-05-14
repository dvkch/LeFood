//
//  Market.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

// https://www.data.gouv.fr/fr/datasets/instances-de-marches-forains-sur-le-territoire-de-la-metropole-de-lyon/#/resources
struct Market: Codable {
    
    // static let apiURL = URL(string: "https://www.data.gouv.fr/fr/datasets/r/8451e152-0941-437f-af53-5ae5802d4c7f")!
    static let apiURL = URL(string: "https://data.grandlyon.com/geoserver/metropole-de-lyon/ows?SERVICE=WFS&VERSION=2.0.0&request=GetFeature&typename=metropole-de-lyon:eco_economie.ecomarcheinstance_latest&outputFormat=application/json&SRSNAME=EPSG:4326")!
    
    let apiID: String
    let geometry: Geometry
    fileprivate(set) var properties: MarketProperties
    
    private enum CodingKeys: String, CodingKey {
        case apiID = "id"
        case geometry = "geometry"
        case properties = "properties"
    }
}

extension Market: Feature {
    var kind: FeatureKind {
        return .market
    }
}

extension Array where Element == Market {
    mutating func deduplicate() {
        print("BEFORE:", count)

        var indicesToRemove = [Int]()
        var existing: [String: Int] = [:]
        existing.reserveCapacity(count)

        for (index, element) in self.enumerated() {
            if let existingIndex = existing[element.id] {
                self[existingIndex].properties.openings.append(contentsOf: element.properties.openings)
                indicesToRemove.append(index)
            }
            else {
                existing[element.id] = index
            }
        }

        for index in indicesToRemove.reversed() {
            self.remove(at: index)
        }

        print("AFTER:", count)
    }
}
