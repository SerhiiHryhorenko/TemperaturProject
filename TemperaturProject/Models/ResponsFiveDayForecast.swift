//
//  ModelOneDayForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 13.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ResponsFiveDayForecast: Decodable {
    let dailyForecasts: [DailyForecastFive]
       
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecastFive
struct DailyForecastFive: Decodable {
    let date: String
    let sun: SunFive
    let temperature: TemperatureFive
    
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case sun = "Sun"
        case temperature = "Temperature"
    }
}

// MARK: - SunFive
struct SunFive: Decodable {
    let rise: String
    let sunSet: String
    
    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case sunSet = "Set"
    }
}

// MARK: - TemperatureFive
struct TemperatureFive: Decodable {
    let minimum: ImumFive
    let maximum: ImumFive
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - ImumFive
struct ImumFive: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
