//
//  ExtensionViewContTableVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
    
    //MARK: - Create sections
    func numberOfSections(in tableView: UITableView) -> Int {
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
               break
           }
        //   return arrDayTemp.count  // 0
        return responseDataForFiveDays?.dailyForecasts.count ?? 0
       }
    
    //MARK: - create TableViewCell
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section {
                //
            case 0:
                let firstCell = tableViewDay.dequeueReusableCell(withIdentifier: "cellDayTemper") as! CellDayTemper
                firstCell.dayTVLabel.text = self.arrDayTemp[indexPath.row].dayName
                firstCell.tMaxLabel.text = "\(arrDayTemp[indexPath.row].maxTemp)"
                firstCell.tMinLabel.text = "\(arrDayTemp[indexPath.row].minTemp)"
                
                
                //            cell.lab.text = self.fiveDayForecast[indexPath.row]?.date
                //            cell.la2.text = String(self.fiveDayForecast[indexPath.row]!.temperature.maximum.value)
                //            cell.label.text = String(self.fiveDayForecast[indexPath.row]!.temperature.minimum.value)

                return firstCell
                
            case 1:
                let secondCell = tableViewDay.dequeueReusableCell(withIdentifier: "sunRiseSet") as! SunRiseSet

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
