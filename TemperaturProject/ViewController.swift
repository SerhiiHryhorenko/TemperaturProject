//
//  ViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 05.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var arrayData = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    var arrSunRS: [ModelTVCellSunRS] = [
           ModelTVCellSunRS(sunRise: "SunRise", sRTime: "4.53", sunSet: "SunSet", sSTime: "3.56")
           ] {
           didSet {
               TableViewDay.reloadData()
           }
       }

       var arrDayTemp: [ModelTVCellDay] = [
           ModelTVCellDay(dayName: "Sunday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Monday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Tuesday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Wensday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Thursday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Friday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Saturday", minTemp: 12.0, maxTemp: 11.0)
           ] {
           didSet {
               TableViewDay.reloadData()
           }
       }
    
    @IBOutlet weak var TableViewDay: UITableView!
    @IBOutlet weak var CollectionViewData: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewDay.delegate = self
        TableViewDay.dataSource = self

        CollectionViewData.delegate = self
        CollectionViewData.dataSource = self
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Create sections
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0:
               return 7
           case 1:
               return 1
           default:
               break
           }
           return arrDayTemp.count  // 0
       }
    
    //MARK: - create TableViewCell
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                let firstCell = TableViewDay.dequeueReusableCell(withIdentifier: "cellDayTemper") as! CellDayTemper

                firstCell.dayLable.text = arrDayTemp[indexPath.row].dayName
                firstCell.tMaxLbl.text = "\(arrDayTemp[indexPath.row].maxTemp)"
                firstCell.tMinLbl.text = "\(arrDayTemp[indexPath.row].minTemp)"

                return firstCell
            case 1:
                let secondCell = TableViewDay.dequeueReusableCell(withIdentifier: "sunRiseSet") as! SunRiseSet

                secondCell.sunRise.text = arrSunRS[indexPath.row].sunRise
                secondCell.sRTime.text = arrSunRS[indexPath.row].sRTime
                secondCell.sunSet.text = arrSunRS[indexPath.row].sunSet
                secondCell.sSTime.text = arrSunRS[indexPath.row].sSTime

                return secondCell
            default:
                return UITableViewCell()
            }
    }
}

    //MARK: - create CollectionViewCell
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(
      _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "cellCVTemp", for: indexPath)
      cell.backgroundColor = .black
      return cell
    }
    
}
