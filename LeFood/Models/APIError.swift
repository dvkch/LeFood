//
//  APIError.swift
//  LeFood
//
//  Created by syan on 13/05/2024.
//

import Foundation

struct APIError: Decodable {
    let message: String
    let details: String?
}
