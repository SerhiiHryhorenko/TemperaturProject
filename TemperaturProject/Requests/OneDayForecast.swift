//
//  OneDayForecast.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 13.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class OneDayForecast {
    let apiKey = APIKey()
    var cityKey = "326175"
    
    
    func fetchDayForecast(cityKey: Int, details: Bool = false, metric: Bool = false, completion: @escaping (ModelOneDayForecast) -> Void) {

        let urlString = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)&details=\(details)&metric=\(metric)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DayForecast URLSession error: \(error.localizedDescription)")
            }
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let dayForecast = try JSONDecoder().decode(ModelOneDayForecast.self, from: data)
                completion(dayForecast)
            } catch let error {
                print("DayForecast decoding error:\(error.localizedDescription)")
            }
        }.resume()
    }
}
