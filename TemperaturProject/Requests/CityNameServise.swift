//
//  CityNameServis.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 29.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class CityNameService {
    var cityKey = "326175"
    
    
    func fetchCityName(cityKey: Int, details: Bool = true, metric: Bool = true, completion: @escaping (ResponsCityName) -> Void) {

       let urlString = "https://dataservice.accuweather.com/locations/v1/326175?apikey=Het3Nj1BBlxighY7eafPBkwGEEuHUq7f"
        // ? var citysName = ResponsCityName
                guard let url = URL(string: urlString) else { return }

                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        // TODO: description change
                        print("CityName URLSession error: \(error.localizedDescription)")
                    }
                    guard let data = data else { return }

                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    do {
                        let city = try JSONDecoder().decode(ResponsCityName.self, from: data)
                        completion(city)
                        print (city.localizedName)

                    } catch let error {
                        print("CityName decoding error: \(error.localizedDescription)")
                    }
                }.resume()
    }
}
