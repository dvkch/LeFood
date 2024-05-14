//
//  Feature.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

protocol Feature<Item>: Codable, Identifiable {
    associatedtype Item: Codable & FeatureProperties
    var apiID: String { get }
    var geometry: Geometry { get }
    var properties: Item { get }
    var kind: FeatureKind { get }
    
    // TODO: maybe use address as stable ID instead? we don't know for sure that the given ID is stable
}

extension Feature {
    var id: String {
        return properties.fullAddress
    }
}
