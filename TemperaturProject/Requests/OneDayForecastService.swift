//
//  OneDayForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 13.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class OneDayForecastService {
    var cityKey = "326175"
    
    
    func fetchDayForecast(cityKey: Int, details: Bool = true, metric: Bool = true, completion: @escaping (ResponsOneDayForecast) -> Void) {

        let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apikey)&details=\(details)&metric=\(metric)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DayForecast URLSession error: \(error.localizedDescription)")
            }
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let dayForecast = try JSONDecoder().decode(ResponsOneDayForecast.self, from: data)
                completion(dayForecast)
            } catch let error {
                print("DayForecast decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
