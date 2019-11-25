//
//  ParsData.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class ParsData{
    func parsingData (data: String) -> (Int, Int, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let formattedDate = dateFormatter.date(from: data)!
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: formattedDate)
        let hours = calendar.component(.hour, from: formattedDate)
        let day = calendar.component(.weekday, from: formattedDate)
            switch day {
                case 2:
                    return (hours, minutes, "Monday")
                case 3:
                    return (hours, minutes, "Tuesday")
                case 4:
                    return (hours, minutes, "Wednesday")
                case 5:
                    return (hours, minutes, "Thursday")
                case 6:
                    return (hours, minutes, "Friday")
                case 7:
                    return (hours, minutes, "Saturday")
                case 1:
                    return (hours, minutes, "Sunday")
                default:
                    return (1,1,"error number day")
            }
    }
}

//let isoDate = "2019-11-20T07:00:00+02:00"
//let a = ParsData()
//a.parsingData(data: isoDate)
//print(a.parsingData(data: isoDate).2)
