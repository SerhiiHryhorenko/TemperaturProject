//
//  ResponsCity.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct City: Decodable {
    let key: String
    //"Key": "1-326175_1_AL"
    enum CodingKeys: String, CodingKey {
        case key = "Key"
    }
}
