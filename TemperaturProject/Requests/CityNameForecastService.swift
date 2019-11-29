//
//  CityNameForecastService.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 29.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class CityNameForecastService {
    var cityKey = "326175"
    
    
    func fetchDayForecast(cityKey: Int, details: Bool = true, metric: Bool = true, completion: @escaping (ResponsCityName) -> Void) {

        let urlString = "https://dataservice.accuweather.com/locations/v1/326175?apikey=Het3Nj1BBlxighY7eafPBkwGEEuHUq7f"
                
                guard let url = URL(string: urlString) else { return }

                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        // TODO: description change
                        print("DayForecast URLSession error: \(error.localizedDescription)")
                    }
                    guard let data = data else { return }

                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    do {
                        let cityName = try JSONDecoder().decode(ResponsCityName.self, from: data)
                        //self.cityName = cityName.LocalizedName
                        completion(cityName)
                    } catch let error {
                        print("DayForecast decoding error: \(error.localizedDescription)")
                    }
                }.resume()
    }
}
