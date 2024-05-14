//
//  MapVC.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit
import MapKit

// TODO: deduplicate markets base on same address, accumulate openings

class MapVC: UIViewController {
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Map.title
        view.backgroundColor = .background
        toolbar.backgroundColor = .backgroundAlt
        toolbar.layer.cornerRadius = 16
        toolbar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let lyonCoordinates = CLLocationCoordinate2D(latitude: 45.7640, longitude: 4.8357)
        mapView.setRegion(MKCoordinateRegion(center: lyonCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: false)
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: "AnnotationView")
        mapView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMap), name: .favoritesChanged, object: nil)

        updateContent()
        refreshContent()
    }
    
    // MARK: Properties
    private var annotations: [AnnotationData] = []
    
    // MARK: Views
    @IBOutlet private var toolbar: UIView!
    @IBOutlet private var updateLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!

    // MARK: Actions
    private func refreshContent() {
        WebAPI.shared.updateData().onSuccess { _ in
            self.updateContent()
        }.onFailure { error in
            UIAlertController.show(for: error, close: L10n.Action.close, in: self)
        }
    }
    
    // MARK: Content
    private func updateContent() {
        updateToolbar()
        updateMap()
    }

    private func updateToolbar() {
        let oldestDate = [
            Preferences.shared.cachedMarkets.updatedDate,
            Preferences.shared.cachedProducers.updatedDate
        ].min()!

        guard oldestDate > Date(timeIntervalSince1970: 0) else {
            updateLabel.isHidden = true
            return
        }

        updateLabel.isHidden = false
        updateLabel.text = L10n.Map.updatedAt(DateFormatter.dateFormatter.string(from: oldestDate))
    }

    @objc private func updateMap() {
        // Compute diff
        let newData = AnnotationData.buildData(
            markets: Preferences.shared.cachedMarkets.features,
            producers: Preferences.shared.cachedProducers.features,
            favorites: Preferences.shared.favorites
        )
        let updates = newData.differences(from: annotations)
        annotations = newData
        
        // Prepare
        let mapAnnotations = mapView.annotations.compactMap { $0 as? Annotation }
        
        // Apply removals
        let annotationIDsToRemove = updates.removed.map(\.id)
        let annotationsToRemove = mapAnnotations.filter { annotationIDsToRemove.contains($0.data.id) }
        mapView.removeAnnotations(annotationsToRemove)
        
        // Apply updates
        let annotationsUpdatesHash = updates.updated.reduce(into: [:], { $0[$1.id] = $1 })
        let annotationsToUpdate = mapAnnotations.filter { annotationsUpdatesHash.keys.contains($0.data.id) }
        annotationsToUpdate.forEach { $0.data = annotationsUpdatesHash[$0.data.id]! }

        // Apply insertions
        let annotationsToInsert = updates.inserted.map { Annotation(data: $0) }
        mapView.addAnnotations(annotationsToInsert)
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView", for: annotation) as! AnnotationView
        view.annotation = annotation
        view.canShowCallout = true
        return view
    }
    
    /*
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [any MKAnnotation]) -> MKClusterAnnotation {
    }
     */
}
