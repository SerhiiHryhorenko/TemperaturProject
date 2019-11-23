//
//  ParsData.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class ParsData{
    func parsingData (data: String) -> (Int, Int, Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let formattedDate = dateFormatter.date(from: data)!
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: formattedDate)
        let hours = calendar.component(.hour, from: formattedDate)
        let day = calendar.component(.weekday, from: formattedDate)
        
        return (hours, minutes, day)
    }
}

//let isoDate = "2019-11-20T07:00:00+02:00"
//let a = ParsData()
//a.parsingData(data: isoDate)
//print(a.parsingData(data: isoDate).2)
