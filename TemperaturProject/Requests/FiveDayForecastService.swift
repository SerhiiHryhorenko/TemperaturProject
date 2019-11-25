//
//  FiveDayForecastService.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 23.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class FiveDayForecastService {
    var cityKey = "326175"
    
    
    func fetchDayForecast(cityKey: Int, details: Bool = true, metric: Bool = true, completion: @escaping (ResponsFiveDayForecast) -> Void) {

        //let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apikey)&details=\(details)&metric=\(metric)"
        
     let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/326175?apikey=Het3Nj1BBlxighY7eafPBkwGEEuHUq7f&details=true&metric=true"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DayForecast URLSession error: \(error.localizedDescription)")
            }
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let dayForecast = try JSONDecoder().decode(ResponsFiveDayForecast.self, from: data)
                completion(dayForecast)
            } catch let error {
                print("DayForecast decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
