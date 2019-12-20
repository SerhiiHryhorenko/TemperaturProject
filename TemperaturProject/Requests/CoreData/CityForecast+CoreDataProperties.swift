//
//  CityForecast+CoreDataProperties.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//
//

import Foundation
import CoreData


extension CityForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityForecast> {
        return NSFetchRequest<CityForecast>(entityName: "CityForecast")
    }

    @NSManaged public var key: String?
    @NSManaged public var city: String?
    @NSManaged public var timeZone: String?

}
