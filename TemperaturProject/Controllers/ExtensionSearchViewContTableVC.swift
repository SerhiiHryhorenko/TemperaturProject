//
//  ExtensionSearchViewContTableVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 20.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

extension SerchViewControler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "cellSerchTabView")!

            return searchCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let searchCell = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? ViewController
        {

            // mainVC.updateView(with: newLocationKey) -- create your update function

            navigationController?.popToRootViewController(animated: false)
        }
    }
}
