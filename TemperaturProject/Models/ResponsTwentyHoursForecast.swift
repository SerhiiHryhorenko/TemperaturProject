//
//  ResponsTwentyHoursForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ResponsTwentyHoursForecast: Decodable {
    let dateTime: String
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case temperature = "Temperature"
    }
}

// MARK: - Temperature
struct Temperature: Decodable {
    let value: Double
   
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
       
    }
}
