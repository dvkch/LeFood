//
//  Log.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation
import os

class Log {
    enum Tag: String {
        case webAPI = "WebAPI"
        case preferences = "Preferences"

        var asOSLog: OSLog {
            return OSLog(subsystem: Bundle.main.bundleIdentifier!, category: rawValue)
        }
    }
    
    private static func log(level: OSLogType, tag: Tag, _ message: String) {
        os_log(level, log: tag.asOSLog, "%@", message)
    }
    
    static func i(_ tag: Tag, _ message: String) {
        log(level: .info, tag: tag, message)
    }
    
    static func w(_ tag: Tag, _ message: String) {
        log(level: .debug, tag: tag, message)
    }

    static func e(_ tag: Tag, _ message: String) {
        log(level: .error, tag: tag, message)
    }
}


