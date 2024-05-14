//
//  Annotation.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import MapKit

class Annotation: MKPointAnnotation {
    
    // MARK: Init
    init(data: AnnotationData) {
        self.data = data
        super.init()
        
        self.coordinate = data.feature.geometry.coordinate
    }

    // MARK: Properties
    enum Content {
        case market(Market, favorited: Bool)
        case producer(Producer, favorited: Bool)
    }
    
    var updatedBlock: (() -> ())?
    var data: AnnotationData {
        didSet {
            updatedBlock?()
        }
    }
}
