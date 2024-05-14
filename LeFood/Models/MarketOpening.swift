//
//  MarketOpening.swift
//  LeFood
//
//  Created by syan on 14/05/2024.
//

import Foundation

struct MarketOpening {
    enum Day: String {
        case monday = "Mo"
        case tuesday = "Tu"
        case wednesday = "We"
        case thursday = "Th"
        case friday = "Fr"
        case saturday = "Sa"
        case sunday = "Su"
        
        var index: Int {
            // TODO: adapt depending on calendar
            switch self {
            case .monday:    return 0
            case .tuesday:   return 1
            case .wednesday: return 2
            case .thursday:  return 3
            case .friday:    return 4
            case .saturday:  return 5
            case .sunday:    return 6
            }
        }
    }
    
    enum Period {
        case morning
        case afternoon
    }
    
    let day: Day
    let timeStart: String
    let timeEnd: String
    let period: Period
}

extension MarketOpening: Codable {
    private enum CodingError: Error {
        case dayAndTimes
        case invalidDay
        case times
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)

        let parts = string.split(separator: " ", maxSplits: 2)
        guard parts.count == 2 else {
            throw CodingError.dayAndTimes
        }
        guard let day = Day(rawValue: String(parts[0])) else {
            throw CodingError.invalidDay
        }
        self.day = day
        
        let times = parts[1].split(separator: "-", maxSplits: 2)
        guard parts.count == 2 else {
            throw CodingError.times
        }
        self.timeStart = String(times[0])
        self.timeEnd = String(times[1])
        self.period = .morning // TODO: choose the proper value
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let string = "\(day.rawValue) \(timeStart)-\(timeEnd)"
        try container.encode(string)
    }
}

extension MarketOpening: CustomStringConvertible {
    var description: String {
        return "\(day.rawValue) \(timeStart) - \(timeEnd)"
    }
}

extension MarketOpening: Comparable {
    static func < (lhs: MarketOpening, rhs: MarketOpening) -> Bool {
        return lhs.day.index < rhs.day.index && lhs.timeStart < rhs.timeStart
    }
}
