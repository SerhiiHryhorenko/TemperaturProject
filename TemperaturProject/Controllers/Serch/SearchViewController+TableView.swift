//
//  ExtensionSearchViewContTableVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

extension SerchViewControler: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "cellSerchTabView", for: indexPath)
        let cities = resultOfRequest[indexPath.row]
        searchCell.textLabel?.text = cities.cityName
        return searchCell
    }
        
    //MARK: - SerchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count >= 3 {
            service.fetchSearchResult(text) { result in
                self.resultOfRequest = result
            }
        } else {
            self.resultOfRequest.removeAll()
        }
        print(searchController.searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //***
        let chous = resultOfRequest[indexPath.row].cityName
        print(resultOfRequest[indexPath.row].cityName)
        
        selectCitySearch = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
        print("selectCity ==>> \(selectCitySearch)")
        
        var flag = 0
        
        if selectCitySearch.count < 1 {
            selectCitySearch.append(chous)
        }
            else{
            for i in selectCitySearch{
                //print(i)
                if chous != i{
                    flag += 1
                }
                print("flag\(flag)  selectCity.count\(selectCitySearch.count) ")
                if flag == selectCitySearch.count {
                    selectCitySearch.append(chous)
                }
            }
        }
        
        UserDefaults.standard.set(selectCitySearch, forKey: "CITY")
        UserDefaults.standard.synchronize()
        print("2    selectCity ==>> \(selectCitySearch)")
        _ = self.navigationController?.popViewController(animated: true)
        
        // ***
        delegate?.selectCityFromSearch(city: resultOfRequest[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

