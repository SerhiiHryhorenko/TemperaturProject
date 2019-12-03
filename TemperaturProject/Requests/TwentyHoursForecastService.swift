//
//  TwentyHoursForecastService.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 24.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class TwentyHoursForecastService {
    var cityKey = "326175"
    
    
    func fetchDayForecast(cityKey: Int, details: Bool = true, metric: Bool = true, completion: @escaping ([ResponsTwentyHoursForecast]) -> Void) {

     let urlString = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(cityKey)?apikey=\(apikey)&details=true&metric=true"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DayForecast URLSession error: \(error.localizedDescription)")
            }
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let dayForecast = try JSONDecoder().decode([ResponsTwentyHoursForecast].self, from: data)
                completion(dayForecast)
                print(dayForecast)
            } catch let error {
                print("DayForecast decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
