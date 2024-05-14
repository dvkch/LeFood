//
//  Snapshot.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import UIKit

struct Snapshot {
    private init() { }

    static var isDoingSnapshots: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    static func setupSnapshots(closure: (Snapshot) -> ()) {
        guard isDoingSnapshots else { return }
        closure(.init())
    }
}

// MARK: Mock data
extension Snapshot {
    var mockInterfaceStyle: UIUserInterfaceStyle {
        if ProcessInfo.processInfo.arguments.contains("DOING_SNAPSHOTS_DARK_MODE") {
            return .dark
        }
        return .light
    }
}
