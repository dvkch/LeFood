//
//  Producer.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

// https://www.data.gouv.fr/fr/datasets/producteurs-locaux-geolocalises-de-la-metropole-de-lyon/
struct Producer: Codable {
    // static let apiURL = URL(string: "https://www.data.gouv.fr/fr/datasets/r/a1caa974-15bf-453f-8d3e-f6f0f2b9a10e")!
    static let apiURL = URL(string: "https://data.grandlyon.com/geoserver/metropole-de-lyon/ows?SERVICE=WFS&VERSION=2.0.0&request=GetFeature&typename=metropole-de-lyon:eco_economie.ecomangerlocal_latest&outputFormat=application/json&SRSNAME=EPSG:4326")!
    
    let apiID: String
    let geometry: Geometry
    let properties: ProducerProperties
    
    private enum CodingKeys: String, CodingKey {
        case apiID = "id"
        case geometry = "geometry"
        case properties = "properties"
    }
}

extension Producer: Feature {
    var kind: FeatureKind {
        return .producer
    }
}
