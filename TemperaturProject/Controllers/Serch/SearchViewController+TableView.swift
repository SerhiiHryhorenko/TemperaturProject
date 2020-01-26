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
        // TODO: get rid of magic numbers
        return resultOfRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "cellSerchTabView", for: indexPath)
        let cities = resultOfRequest[indexPath.row]
        searchCell.textLabel?.text = cities.cityName
        return searchCell
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//                curentArrayNames = arrayNames.filter({city -> Bool in
//                city.lowercased().contains(searchText.lowercased())
//                })
//        tableSearch.reloadData()
//        }
//    }
        
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
        delegate?.selectCityFromSearch(city: resultOfRequest[indexPath.row])
        
        navigationController?.popViewController(animated: true)
    }
}

