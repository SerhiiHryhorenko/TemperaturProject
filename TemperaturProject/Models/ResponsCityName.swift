//
//  ResponsCity.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ResponsCityName: Decodable {
    // TODO: lowercase
    var localizedName: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
    }
}
