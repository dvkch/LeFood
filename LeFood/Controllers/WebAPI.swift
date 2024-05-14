//
//  WebAPI.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation
import Alamofire
import BrightFutures

class WebAPI {
    
    // MARK: Init
    static let shared = WebAPI()
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        session = Alamofire.Session(configuration: configuration)
    }
    
    // MARK: Properties
    private var session: Session

    // MARK: Generic
    private func request<T: Decodable>(_ url: URL, _ type: T.Type) -> Future<T, AppError> {
        Log.i(.webAPI, "LOADING \(url)")
        return session.request(url: url, method: .get, params: [:]).codable(type: T.self)
    }

    // MARK: APIs
    func updateData() -> Future<(), AppError> {
        return [
            getMarkets().map { _ in () },
            getProducers().map { _ in () }
        ].sequence().map { _ in () }
    }
    
    private func getMarkets() -> Future<Page<Market>, AppError> {
        return request(Market.apiURL, Page<Market>.self).onSuccess { markets in
            var cleanedUpMarkets = markets
            cleanedUpMarkets.features.deduplicate()
            Preferences.shared.cachedMarkets = cleanedUpMarkets
        }
    }

    private func getProducers() -> Future<Page<Producer>, AppError> {
        return request(Producer.apiURL, Page<Producer>.self).onSuccess { producers in
            Preferences.shared.cachedProducers = producers
        }
    }
}
