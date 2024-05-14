//
//  Array+SY.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

// TODO: add to SYKit
extension Array where Element: Equatable & Identifiable {
    func differences(from older: Self) -> (inserted: [Element], updated: [Element], removed: [Element]) {
        let diff = self.difference(from: older)
        
        var inserted = diff.insertions.map(\.element)
        var removed = diff.removals.map(\.element)
        
        let insertedIDs = Set(inserted.map(\.id))
        let removedIDs = Set(removed.map(\.id))
        let updatedIDs = insertedIDs.intersection(removedIDs)

        let updated = (inserted + removed).filter { updatedIDs.contains($0.id) }
        inserted.removeAll(where: { updatedIDs.contains($0.id) })
        removed.removeAll(where: { updatedIDs.contains($0.id) })

        return (inserted, updated, removed)
    }
}

extension CollectionDifference.Change {
    var element: ChangeElement {
        switch self {
        case .insert(_, let element, _):
            return element
        case .remove(_, let element, _):
            return element
        }
    }
}
