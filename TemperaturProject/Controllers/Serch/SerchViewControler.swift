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
    
    @IBAction func goToRoot(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
    }
    
    let service = CityNameServiceText()
    var selectCitySearch: [String] = []
    var resultOfRequest = [ResponsSearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableSearch.reloadData()
            }
        }
    }
    
    let searchCity = UISearchController(searchResultsController: nil)
    weak var delegate: ListCityViewController?
    
    
    //MARK: - передача данних
    
    
    //MARK: - SearchVC life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        searchCity.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchCity
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToListCity"{
            _ = segue.destination as! ListCityViewController
        }
    }

    fileprivate func setupNavigationBar(){
        self.navigationItem.title = "Сhoice of city"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let serchController = UISearchController(searchResultsController: nil)
        serchController.searchResultsUpdater = self
    }
}
