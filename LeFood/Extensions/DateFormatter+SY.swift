//
//  DateFormatter+SY.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

extension DateFormatter {
    static let isoFormatter = {
        // 2022-04-30T00:00:00.000Z
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        return isoFormatter
    }()
    
    static let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }()
}
