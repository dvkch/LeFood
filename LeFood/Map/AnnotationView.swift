//
//  AnnotationView.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import MapKit

class AnnotationView: MKAnnotationView {
    
    // MARK: Init
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        detailCalloutAccessoryView = labelsStackView
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .callout)
        titleLabel.textColor = .text
        labelsStackView.addArrangedSubview(titleLabel)
        
        detailsLabel.numberOfLines = 0
        detailsLabel.font = .preferredFont(forTextStyle: .footnote)
        detailsLabel.textColor = .textAlt
        labelsStackView.addArrangedSubview(detailsLabel)

        favoriteButton.addTarget(self, action: #selector(self.toggleFavoriteTap), for: .primaryActionTriggered)
        favoriteButton.setImage(.icon(.bookmark), for: .normal)
        favoriteButton.setImage(.icon(.bookmarkFill), for: .selected)
        rightCalloutAccessoryView = favoriteButton

        updateContent()
    }
    
    // MARK: Views
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let favoriteButton = UIButton(configuration: .gray())
    
    // MARK: Properties
    override var annotation: (any MKAnnotation)? {
        didSet {
            self.typedAnnotation = annotation as? Annotation
            updateContent()
        }
    }
    
    private var typedAnnotation: Annotation? {
        didSet {
            oldValue?.updatedBlock = nil
            typedAnnotation?.updatedBlock = { [weak self] in
                self?.updateContent()
            }
            updateContent()
        }
    }
    
    // MARK: Action
    @objc private func toggleFavoriteTap() {
        guard let typedAnnotation else { return }
        let isFavorited = Preferences.shared.isItemFavorited(typedAnnotation.data.feature)
        Preferences.shared.mark(typedAnnotation.data.feature, favorited: !isFavorited)
    }
    
    // MARK: Content
    private func updateContent() {
        guard let typedAnnotation else { return }
        
        // TODO: better icons
        switch typedAnnotation.data.feature.kind {
        case .market:
            self.image = .icon(.bookmarkFill)

        case .producer:
            self.image = .icon(.bookmarkFill)
        }
        
        titleLabel.text = typedAnnotation.data.feature.properties.name
        detailsLabel.text = typedAnnotation.data.feature.properties.details
        favoriteButton.isSelected = typedAnnotation.data.favorited
        favoriteButton.accessibilityLabel = typedAnnotation.data.favorited ? L10n.Action.unfavorite : L10n.Action.favorite
        favoriteButton.sizeToFit()
    }
}
