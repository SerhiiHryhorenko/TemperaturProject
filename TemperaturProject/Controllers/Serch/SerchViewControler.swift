//
//  SerchViewControler.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 21.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class SerchViewControler: UIViewController {

    @IBOutlet weak var tableSearch: UITableView!
    
    let service = CityNameServiceText()
    let presenter = ModelSearch()
    var resultOfRequest = [ResponsSearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableSearch.reloadData()
            }
        }
    }
    
    let searchCity = UISearchController(searchResultsController: nil)
    var arrayNames = ListCityViewController()
    var curentArrayNames = ListCityViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        //setUpCityName()
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        tableSearch.tableHeaderView = searchCity.searchBar

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
    
    
}
