//
//  ExtensionViewContTableVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
    
    //MARK: - Create sections
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        switch section {
           case 0:
               return 7
           case 1:
               return 1
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
                
//                let temp = TemperatureOne(minimum: <#T##ImumOne#>, maximum: <#T##ImumOne#>)
//                print (temp.maximum)

                
                //                guard let firstCell = tableViewDay.dequeueReusableCell(withIdentifier: "cellDayTemper") as? CellDayTemper
//                    let data = responseDataForFiveDays?.dailyForecasts[indexPath.row]
//                    else {
//                        return UITableViewCell()
//                    }
                
                let firstCell = tableViewDay.dequeueReusableCell(withIdentifier: "cellDayTemper") as! CellDayTemper
                firstCell.dayTVLabel.text = arrDayTemp[indexPath.row].dayName
                firstCell.tMaxLabel.text = "\(arrDayTemp[indexPath.row].maxTemp)"
                firstCell.tMinLabel.text = "\(arrDayTemp[indexPath.row].minTemp)"

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
//}
//    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDayTemper") as? CustomTableViewCell,
//        let data = responseDataForFiveDays?.dailyForecasts[indexPath.row]
//        else {
//            return UITableViewCell()
//        }
//
//    cell.configure(model: data)
//    return cell
//}
}
