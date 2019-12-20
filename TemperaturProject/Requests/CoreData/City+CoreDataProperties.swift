//
//  City+CoreDataProperties.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityKey: String?
    @NSManaged public var cityName: String?
    @NSManaged public var timeZone: String?

}
