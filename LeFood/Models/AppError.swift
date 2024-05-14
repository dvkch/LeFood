//
//  AppError.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation
import UIKit
import Alamofire
import SYKit

enum AppError {
    case request(_ response: AlamofireDataResponse)
    case decoding(_ kind: String, _ error: Error?, _ message: String?)
    case cancelled
    case offline
    #if DEBUG
    case notImplemented
    #endif
}

extension AppError : LocalizedError {
    var errorDescription: String? {
        if isOfflineError {
            return L10n.Error.offline
        }
        
        switch self {
        case .request(let r):
            if let apiError {
                return [apiError.message, apiError.details].compactMap { $0 }.joined(separator: ": ")
            }
            return r.error?.localizedDescription ?? L10n.Error.request
        case .decoding(let k, let e, let m):return L10n.Error.decoding(k, e?.localizedDescription ?? m ?? "")
        case .cancelled:                    return L10n.Error.cancelled
        case .offline:                      return L10n.Error.offline
#if DEBUG
        case .notImplemented:               return "NOT IMPLEMENTED"
#endif
        }
    }
    
    var apiError: APIError? {
        guard case let .request(response) = self else { return nil }
        return try? JSONDecoder().decode(APIError.self, from: response.data)
    }
    
    var underlyingError: Error? {
        switch self {
        case .request(let r):               return r.error?.underlyingError ?? r.error
        case .decoding(_, let e, _):        return e
        case .cancelled:                    return nil
        case .offline:                      return nil
#if DEBUG
        case .notImplemented:               return nil
#endif
        }
    }
    
    var isOfflineError: Bool {
        if case .offline = self {
            return true
        }
        
        guard var error = underlyingError else { return false }
        if error.isOfflineError {
            return true
        }
        
        while error.underlyingErrors.isNotEmpty {
            error = error.underlyingErrors[0]
            if error.isOfflineError {
                return true
            }
        }
        return false
    }
}

extension Error {
    fileprivate var underlyingErrors: [Error] {
        var errors = [Error]()
        if let e = (self as NSError).userInfo[NSUnderlyingErrorKey] as? NSError {
            errors.append(e)
        }
        if #available(iOS 14.5, *) {
            errors += (self as NSError).userInfo[NSMultipleUnderlyingErrorsKey] as? [NSError] ?? []
        }
        return errors
    }
}
