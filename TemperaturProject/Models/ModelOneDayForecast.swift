//
//  ModelOneDayForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 13.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ModelOneDayForecast: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline
        case dailyForecasts
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: Date
    let epochDate: Int
    let sun: Sun
    let moon: Moon
    let temperature, realFeelTemperature, realFeelTemperatureShade: RealFeelTemperature
    let hoursOfSun: Double
    let degreeDaySummary: DegreeDaySummary
    let airAndPollen: [AirAndPollen]
    let day, night: Day
    let sources: [String]
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case date
        case epochDate
        case sun
        case moon
        case temperature
        case realFeelTemperature
        case realFeelTemperatureShade
        case hoursOfSun
        case degreeDaySummary
        case airAndPollen
        case day
        case night
        case sources
        case mobileLink
        case link
    }
}

// MARK: - AirAndPollen
struct AirAndPollen: Codable {
    let name: String
    let value: Int
    let category: String
    let categoryValue: Int
    let type: String?

    enum CodingKeys: String, CodingKey {
        case name
        case value
        case category
        case categoryValue
        case type
    }
}

// MARK: - Day
struct Day: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let shortPhrase, longPhrase: String
    let precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int
    let iceProbability: Int
    let wind, windGust: Wind
    let totalLiquid, rain, snow, ice: Ice
    let hoursOfPrecipitation, hoursOfRain, hoursOfSnow, hoursOfIce: Int
    let cloudCover: Int

    enum CodingKeys: String, CodingKey {
        case icon
        case iconPhrase
        case hasPrecipitation
        case shortPhrase
        case longPhrase
        case precipitationProbability
        case thunderstormProbability
        case rainProbability
        case snowProbability
        case iceProbability
        case wind
        case windGust
        case totalLiquid
        case rain
        case snow
        case ice
        case hoursOfPrecipitation
        case hoursOfRain
        case hoursOfSnow
        case hoursOfIce
        case cloudCover
    }
}

// MARK: - Ice
struct Ice: Codable {
    let value: Double
    let unit: Unit
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value
        case unit
        case unitType
    }
}

enum Unit: String, Codable {
    case c = "C"
    case cm = "cm"
    case kmH = "km/h"
    case mm = "mm"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Ice
    let direction: Direction

    enum CodingKeys: String, CodingKey {
        case speed
        case direction
    }
}

// MARK: - Direction
struct Direction: Codable {
    let degrees: Int
    let localized, english: String

    enum CodingKeys: String, CodingKey {
        case degrees
        case localized
        case english
    }
}

// MARK: - DegreeDaySummary
struct DegreeDaySummary: Codable {
    let heating, cooling: Ice

    enum CodingKeys: String, CodingKey {
        case heating
        case cooling
    }
}

// MARK: - Moon
struct Moon: Codable {
    let rise: Date
    let epochRise: Int
    let moonSet: Date
    let epochSet: Int
    let phase: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case rise
        case epochRise
        case moonSet
        case epochSet
        case phase
        case age
    }
}

// MARK: - RealFeelTemperature
struct RealFeelTemperature: Codable {
    let minimum, maximum: Ice

    enum CodingKeys: String, CodingKey {
        case minimum
        case maximum
    }
}

// MARK: - Sun
struct Sun: Codable {
    let rise: Date
    let epochRise: Int
    let sunSet: Date
    let epochSet: Int

    enum CodingKeys: String, CodingKey {
        case rise
        case epochRise
        case sunSet
        case epochSet
    }
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: Date
    let effectiveEpochDate, severity: Int
    let text, category: String
    let endDate, endEpochDate: JSONNull?
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate
        case effectiveEpochDate
        case severity
        case text
        case category
        case endDate
        case endEpochDate
        case mobileLink
        case link
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    
    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
