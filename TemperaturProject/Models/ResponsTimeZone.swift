//
//  ResponsTimeZone.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct RootResponse: Codable {
     struct ResponsTimeZone: Codable {
         let name: String
         let gmtOffset: Int

         private enum CodingKeys: String, CodingKey {
             case name = "Name"
             case gmtOffset = "GmtOffset"
         }
     }
     var  timeZone: ResponsTimeZone

    enum CodingKeys: String, CodingKey {
        case timeZone = "TimeZone"
    }
}
