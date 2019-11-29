//
//  ResponsCity.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

struct ResponsCityName: Decodable {
    let key: String
    //"Key": "326175"
    enum CodingKeys: String, CodingKey {
        case key = "Key"
    }
}
