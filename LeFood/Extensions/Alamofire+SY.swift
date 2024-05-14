//
//  Alamofire+SY.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Alamofire
import BrightFutures
import Foundation

struct AlamofireDataResponse: CustomDebugStringConvertible {
    let data: Data
    let error: AFError?
    let request: URLRequest?
    let response: HTTPURLResponse?
    let metrics: URLSessionTaskMetrics?
    
    var debugDescription: String {
        var parts = [String]()
        if let request {
            parts.append("Request:")
            parts.append("- method: \(request.httpMethod ?? "")")
            parts.append("- url: \(request.url?.absoluteString ?? "")")
            if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                parts.append("- body: \(bodyString)")
            }
        }
        if let response {
            parts.append("Response:")
            parts.append("- status: \(response.statusCode)")
            parts.append(String(data: data, encoding: .utf8) ?? "")
        }
        return parts.joined(separator: "\n")
    }
}

extension Session {
    func request(
        url: URLConvertible, method: HTTPMethod = .get,
        params: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) -> Future<AlamofireDataResponse, AppError> {
        return Future<AlamofireDataResponse, AppError> { resolver in
            self.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
                .validate()
                .responseData(queue: .main) { response in
                    let r = AlamofireDataResponse(
                        data: response.data ?? Data(),
                        error: response.error,
                        request: response.request,
                        response: response.response,
                        metrics: response.metrics
                    )
                    switch response.result {
                    case .success:
                        resolver(.success(r))
                    case .failure:
                        resolver(.failure(AppError.request(r)))
                    }
                }
        }
    }
}

extension Future where T == AlamofireDataResponse, E == AppError {
    func data() -> Future<Data, E> {
        return map { $0.data }
    }

    func codable<U: Decodable>(type: U.Type) -> Future<U, E> {
        return flatMap { data -> Result<U, E> in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.isoFormatter)
                let decoded = try decoder.decode(U.self, from: data.data)
                return .success(decoded)
            }
            catch {
                Log.e(.webAPI, "Error decoding response: \(error)")
                Log.e(.webAPI, data.debugDescription)
                Log.e(.webAPI, "-----------------")
                return .failure(.decoding(String(describing: U.self), error, nil))
            }
        }
    }
}
