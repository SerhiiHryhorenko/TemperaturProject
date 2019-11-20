//
//  ViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 05.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    var arrayTime = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    var arrSunRS: [ModelTVCellSunRS] = [
           ModelTVCellSunRS(sunRise: "SunRise", sRTime: "4.53", sunSet: "SunSet", sSTime: "3.56")
           ] {
           didSet {
               tableViewDay.reloadData()
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
               tableViewDay.reloadData()
           }
       }
    @IBOutlet weak var tableViewDay: UITableView!
    @IBOutlet weak var collectionViewDay: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDay.delegate = self
        tableViewDay.dataSource = self

        collectionViewDay.delegate = self
        collectionViewDay.dataSource = self
        
        let oneDayForecast = OneDayForecast()
        oneDayForecast.fetchDayForecast(cityKey: 326175, completion: workWithFiveDaysForecastData(_:))
    }
    
//    unc workWithDailyForecastData(_ data: [TwelveHoursForecastResponse]) -> Void {
//        responseDataForTwelveHours = data
//    }
    var responseDataForFiveDays: ResponsFiveDayForecast? {
        didSet {
            tableViewDay.reloadData()
        }
    }
    
    func workWithFiveDaysForecastData(_ data: ResponsFiveDayForecast) -> Void {
        responseDataForFiveDays = data
    }

    func workWithError(_ error: Error) -> Void {
        print(error)
    }

}



