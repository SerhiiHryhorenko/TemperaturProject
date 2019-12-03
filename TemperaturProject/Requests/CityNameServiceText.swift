//
//  CityNameServiceText.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 03.12.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class CityNameServiceText {

    var cityKey = "326175"
    func fetchSearchResult(_ query: String, completion: @escaping ([ResponsSearchResult]) -> ()) {
        guard let url = URL(string: "https://dataservice.accuweather.com/locations/v1/\(cityKey)?apikey=\(apikey)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("SearchResultError: \(error!.localizedDescription)")
            }
            guard let data = data else {
                print("SearchResultError:downloading error, \(error!.localizedDescription)")
                return
            }

            do {
                let searchResult = try JSONDecoder().decode([ResponsSearchResult].self, from: data)
                completion(searchResult)
                } catch {
                    print("SearchResultError:decoding error, \(error.localizedDescription)")
                }
        }.resume()
    }

}
