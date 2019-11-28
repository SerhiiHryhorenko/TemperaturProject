//
//  ExtensionViewContTableVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Temperature by day of the week"
        } else {
            return "Sunrise and sunset time"
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Create sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: get rid of magic numbers
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        switch section {
        case 0:
            return arrDayTemp.count
        case 1:
            return arrSunRS.count
        default:
            return 0
        }
    }
    
    //MARK: - create TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        //
        case 0:
            let firstCell = tableViewDay.dequeueReusableCell(withIdentifier: "cellDayTemper") as! CellDayTemper
            // TODO: rename 'arrDayTemp'
            let dailyTemperatureInfo = arrDayTemp[indexPath.row]
            
            firstCell.dayTVLabel.text = dailyTemperatureInfo.dayName
            firstCell.tMaxLabel.text = "\(dailyTemperatureInfo.maxTemp)"
            firstCell.tMinLabel.text = "\(dailyTemperatureInfo.minTemp)"
            
            return firstCell
            
        case 1:
            let secondCell = tableViewDay.dequeueReusableCell(withIdentifier: "sunRiseSet") as! SunRiseSet
            
            //TODO: add variable for 'arrSunRS[indexPath.row]' and rename 'arrSunRS'
            secondCell.sunRiseLabel.text = arrSunRS[indexPath.row].sunRise
            secondCell.sRTimeLabel.text = arrSunRS[indexPath.row].sRTime
            secondCell.sunSetLabel.text = arrSunRS[indexPath.row].sunSet
            secondCell.sSTimeLabel.text = arrSunRS[indexPath.row].sSTime
            
            return secondCell
            
        default:
            return UITableViewCell()
        }
    }
    
}
