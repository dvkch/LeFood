//
//  Geometry.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation
import MapKit

struct Geometry: Codable, Equatable {
    let kind: Kind
    let coordinates: [Double]
    
    enum Kind: String, Codable {
        case point = "Point"
    }
    
    enum CodingKeys: String, CodingKey {
        case kind = "type"
        case coordinates = "coordinates"
    }
}

extension Geometry {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
    }
}
