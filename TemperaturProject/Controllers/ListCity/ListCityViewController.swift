//
//  ListCity.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 26.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class ListCityViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    public weak var delegate: MainViewController?
    
    let city = ResponsCityName(localizedName: "name")
    let identifier = "myCell"
    
    var listCity : [String] = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
    
    var favoriteCities: [ResponsSearchResult] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let savedCities = UserDefaults.standard.array(forKey: "cities") as? [String]
        if savedCities != nil {
            
        }
        
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func addCity(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let listVC = storyboard.instantiateViewController(withIdentifier: "SerchViewControler") as? SerchViewControler {
            listVC.delegate = self
            navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
    @IBAction func editTable(_ sender: Any) {
        myTableView.isEditing = !myTableView.isEditing
    }
    
    func selectCityFromSearch(city: ResponsSearchResult) {
        favoriteCities.append(city)
        
    }

}
    
//    // Save city
//    // get saved cities:
//    var savedCities = UserDefaults.standard.array(forKey: "cities") as? [String] ?? []
//
//    // TODO: if not contains
//    // add new selected city
//    savedCities.append(cities[indexPath.row].localizedName)
//    // save changes
//    UserDefaults.standard.set(savedCities, forKey: "cities")

extension ListCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.selectCityFromSearch(city: favoriteCities[indexPath.row])
        navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = favoriteCities[indexPath.row].cityName
        
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            favoriteCities.remove(at: indexPath.row)
            
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .left)
            })
        }
        UserDefaults.standard.set(favoriteCities, forKey: "CITY")
        UserDefaults.standard.synchronize()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = favoriteCities[sourceIndexPath.row]
        favoriteCities.remove(at: sourceIndexPath.row)
        favoriteCities.insert(item, at: destinationIndexPath.row)
        UserDefaults.standard.set(favoriteCities, forKey: "CITY")
        UserDefaults.standard.synchronize()
        isEditing = false
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            print("Copy")
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            let cell = tableView.cellForRow(at: indexPath)
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = cell?.textLabel?.text
        }
    }
}
