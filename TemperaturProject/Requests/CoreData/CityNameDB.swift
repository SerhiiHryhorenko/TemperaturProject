//
//  CityNameDB.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 19.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer = NSPersistentContainer(name: "City")
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func initalizeStack() {
    
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
            print("store loaded")
        }
    }
    
    func insertCity(withBook: Bool) throws {
        let city = City(context: self.context)
        city.nameCity = "Vinnytsia"
        self.context.insert(city)
        try self.context.save()
    }
    
    func fetchCities() throws -> [City] {
        let city = try self.context.fetch(City.fetchRequest() as NSFetchRequest<City>)
        return city
    }
    
    func fetchCities(withName name: String) throws -> [City] {
        let request = NSFetchRequest<City>(entityName: "City")
        request.predicate = NSPredicate(format: "nameCity == %@", name)
        
        let cities = try self.context.fetch(request)
        return cities
    }
    
    func update(user: City) throws {
        city.nameCity = "Vinnytsia"
        try self.context.save()
    }
    
    func delete(user: City) throws {
        self.context.delete(city)
        try self.context.save()
    }
    
    func deleteCities(withName name: String) throws {
        let fetchRequest = City.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "nameCity == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
    
}
