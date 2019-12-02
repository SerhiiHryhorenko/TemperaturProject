//
//  SerchViewControler.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 21.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class SerchViewControler: UIViewController, UISearchResultsUpdating {
    
    
    @IBOutlet weak var tableSearch: UITableView!
    
    
    var arrayNames = ListCityViewController()
    var curentArrayNames = ListCityViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        setUpCityName()

    }
    
    private func setUpCityName() {
        
        for i in arrayNames.array {
            arrayNames.array.append("cityName \(i)")
        }
        
        curentArrayNames = arrayNames
    }
    
    fileprivate func setupNavigationBar(){
        self.navigationItem.title = "***"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let serchController = UISearchController(searchResultsController: nil)
        serchController.searchResultsUpdater = self
        
        navigationItem.searchController = serchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //let service = CityNameService()
    
    //MARK: - SerchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
//         guard let text = searchController.searchBar.text else { return }
//
//               if text.count >= 3 {
//
//                   service.fetchCityName(text) { searchedCities in
//
//                       self.cities = searchedCities
//
//                       DispatchQueue.main.async {
//                           self.tableView.reloadData()
//                       }
//                   }
//               }
//
//        print(searchController.searchBar.text)
    }
}
