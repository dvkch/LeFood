//
//  Page.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

struct Page<T: Feature>: Codable {
    var features: [T]
    let updatedDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case features = "features"
        case updatedDate = "timeStamp"
    }
    
    init(features: [T] = [], updatedDate: Date = .init(timeIntervalSince1970: 0)) {
        self.features = features
        self.updatedDate = updatedDate
    }
}
