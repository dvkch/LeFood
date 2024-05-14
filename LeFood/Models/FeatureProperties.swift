//
//  FeatureProperties.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

protocol FeatureProperties {
    var addressStreet: String { get }
    var addressZipCode: String { get }
    var addressCity: String { get }

    var name: String { get }
    var details: String { get }
}

extension FeatureProperties {
    var fullAddress: String {
        return "\(addressStreet)\n\(addressZipCode) \(addressCity)"
    }
}
