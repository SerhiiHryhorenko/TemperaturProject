//
//  ParsData.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ForecastDate {
    var hour: Int
    var minute: Int
    var day: String
}

class DateParser {
    
    static func parsDate(_ dateStr: String, timeZoneId: String) -> ForecastDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.timeZone = TimeZone(identifier: timeZoneId)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let formattedDate = dateFormatter.date(from: dateStr)!
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: timeZoneId)!
        let minutes = calendar.component(.minute, from: formattedDate)
        let hours = calendar.component(.hour, from: formattedDate)
        let day = calendar.component(.weekday, from: formattedDate)
        //let timeZone = calendar.component(.timeZone, from: formattedDate)
        var dayName: String
        switch day {
        case 2:
            dayName = "Monday"
        case 3:
            dayName = "Tuesday"
        case 4:
            dayName = "Wednesday"
        case 5:
            dayName = "Thursday"
        case 6:
            dayName = "Friday"
        case 7:
            dayName = "Saturday"
        case 1:
            dayName = "Sunday"
        default:
            dayName = "Everyday"
        }
        
        return ForecastDate(hour: hours, minute: minutes, day: dayName)
    }
}

//let isoDate = "2019-11-20T07:00:00+02:00"
//let a = ParsData()
//a.parsingData(data: isoDate)
//print(a.parsingData(data: isoDate).2)
