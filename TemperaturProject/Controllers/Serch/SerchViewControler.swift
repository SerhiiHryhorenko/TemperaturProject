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
    
//    @IBAction func pushListCityVCAction(_ sender: UIButton) {
//        //let _ = UIStoryboard(name: "Main", bundle: nil)
//           
//        if let searchVC = storyboard!.instantiateViewController(withIdentifier: "ListCityViewController") as? ListCityViewController {
//            //searchVC.delegate =
//        navigationController?.pushViewController(searchVC, animated: true)
//        }
//    }
    
    
    //    @IBAction func pushListVCAction(_ sender: Any) {
    //        let _ = UIStoryboard(name: "Main", bundle: nil)
    //
    //        if let mainVC = storyboard!.instantiateViewController(withIdentifier: "ListCityViewController") as? ListCityViewController {
    //            mainVC.delegate = self
    //            navigationController?.pushViewController(mainVC, animated: true)
    //        }
    //    }
    
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
    weak var delegate: ListCityViewController?
    //var curentArrayNames = ListCityViewController()
    
    
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
        //setUpCityName()
        searchCity.searchResultsUpdater = self
        definesPresentationContext = true
        searchCity.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchCity
    }

    fileprivate func setupNavigationBar(){
        self.navigationItem.title = "Сhoice of city"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let serchController = UISearchController(searchResultsController: nil)
        serchController.searchResultsUpdater = self
        
    }
}
