//
//  ResponsOneDayForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 19.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

// MARK: - ResponsOneDayForecast        dailyForecast.sun.rise
struct ResponsOneDayForecast: Decodable {
    let dailyForecasts: [DailyForecastOne]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecastOne
struct DailyForecastOne: Decodable {
    let date: String
    let sun: Sun
    let temperature: TemperatureOne
    
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case sun = "Sun"
        case temperature = "Temperature"
    }
}

// MARK: - SunOne
struct Sun: Decodable {
    let rise: String
    let set: String
    
    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case set = "Set"
    }
}

// MARK: - TemperatureOne
struct TemperatureOne: Decodable {
    let minimum: ImumOne
    let maximum: ImumOne
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - ImumOne
struct ImumOne: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
