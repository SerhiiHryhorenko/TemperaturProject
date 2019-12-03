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
        return curentArrayNames.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let searchCell = tableView.dequeueReusableCell(withIdentifier: "cellSerchTabView") as? CellCityName else {return UITableViewCell()}
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
              //let text1 = ResponsCityName(localizedName: "")
                if text.count >= 3 {
                    presenter.searchService.fetchSearchResult(text) { result in
                        self.resultOfRequest = result
                        }
                    } else {
                        self.resultOfRequest.removeAll()
                    }

            print(searchController.searchBar.text!)
         }
        
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if storyboard.instantiateViewController(withIdentifier: "MainViewController") is MainViewController
        {

            // mainVC.updateView(with: newLocationKey) -- create your update function

            navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
}

