//
//  ResponsSearchResult.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 03.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ResponsSearchResult: Codable {
    var key: String
    var cityName: String
   // var country: CountryName
    
    private enum CodingKeys: String, CodingKey {
        case key      = "Key"
        case cityName = "CityName"
      //  case country  = "Country"
    }
}

//struct CountryName: Codable {
//    var name: String
//    private enum CodingKeys: String, CodingKey {
//        case name = "LocalizedName"
//    }
//}
