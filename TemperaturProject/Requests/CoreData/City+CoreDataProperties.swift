//
//  City+CoreDataProperties.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 19.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nameCity: String?

}
