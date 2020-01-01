//
//  CityTimeZone.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class CityTimeZone {
    var cityKey = "326175"
    
    func fetchTimeZone(cityKey: Int, details: Bool = true, completion: @escaping (RootResponse) -> Void) {

       let urlString = "https://dataservice.accuweather.com/locations/v1/\(cityKey)?apikey=\(apikey)&details=true"
                guard let url = URL(string: urlString) else { return }

                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("TimeZone URLSession error: \(error.localizedDescription)")
                    }
                    guard let data = data else { return }

                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    do {
                        let localZone = try JSONDecoder().decode(RootResponse.self, from: data)
                        completion(localZone)
                        //print (localZone.timeZone.gmtOffset)

                    } catch let error {
                        print("TimeZone decoding error: \(error.localizedDescription)")
                    }
                }.resume()
    }
}
