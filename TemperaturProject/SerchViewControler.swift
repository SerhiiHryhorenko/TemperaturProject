//
//  SerchViewControlerViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class SerchViewControler: UIViewController, UISearchResultsUpdating {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    fileprivate func setupNavigationBar(){
        self.navigationItem.title = "***"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let serchController = UISearchController(searchResultsController: nil)
        serchController.searchResultsUpdater = self
        
        navigationItem.searchController = serchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: - SerchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
//         guard let text = searchController.searchBar.text else { return }
//
//               if text.count >= 3 {
//
//                   service.fetchCities(text) { searchedCities in
//
//                       self.cities = searchedCities
//
//                       DispatchQueue.main.async {
//                           self.tableView.reloadData()
//                       }
//                   }
//               }

        //print(searchController.searchBar.text)
    }
//https://dataservice.accuweather.com/locations/v1/cities/search?q=Vinnytsya&apikey=Het3Nj1BBlxighY7eafPBkwGEEuHUq7f
}
