//
//  ViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 05.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewDay: UITableView!
    @IBOutlet weak var collectionViewDay: UICollectionView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempCityNameLabel: UILabel!
    
    let parsData = ParsData()
    
    // MARK: - DATA SOURCE:
    private var currentTemperature: Double? {
        didSet {
            if let currentTemperature = self.currentTemperature {
                DispatchQueue.main.async {
                    self.tempCityNameLabel.text = "\(currentTemperature)º"
                }
            }
        }
    }
    var responseDataForFiveDays: ResponsFiveDayForecast? {
        didSet {
            tableViewDay.reloadData()
        }
    }
    
    private let oneDayForecastService = OneDayForecastService()
    private let fiveDayForecastService = FiveDayForecastService()
    private let twentyHoursForecastService = TwentyHoursForecastService()
    
    var arrayTimeCV = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var arrayTemperCV = ["12", "12", "12", "12", "12", "12", "12", "12", "11", "11", "10", "10", "10"]
    
    var arrSunRS: [ModelTVCellSunRS] = [
           ModelTVCellSunRS(sunRise: "SunRise", sRTime: "4.53", sunSet: "SunSet", sSTime: "3.56")
           ] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewDay.reloadSections(IndexSet(arrayLiteral: 1), with: UITableView.RowAnimation.automatic)
            }
        }
       }

       var arrDayTemp: [ModelTVCellDay] = [
           ModelTVCellDay(dayName: "Tuesday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Wensday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Thursday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Friday", minTemp: 12.0, maxTemp: 11.0),
           ModelTVCellDay(dayName: "Saturday", minTemp: 12.0, maxTemp: 11.0)
           ] {
           didSet {
               DispatchQueue.main.async {
                   self.tableViewDay.reloadSections(IndexSet(arrayLiteral: 0), with: UITableView.RowAnimation.automatic)
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDay.delegate = self
        tableViewDay.dataSource = self

        collectionViewDay.delegate = self
        collectionViewDay.dataSource = self
        
        // MARK: - RELOAD DATA TV SUN RISE_SET:
        oneDayForecastService.fetchDayForecast(cityKey: 326175) { (oneDayForecast) in
            print(oneDayForecast)
            if let dailyForecast = oneDayForecast.dailyForecasts.first {
                self.currentTemperature = dailyForecast.temperature.maximum.value
                self.arrSunRS = [ModelTVCellSunRS(sunRise: "Sunrise",
                                                  sRTime: "\(self.parsData.parsingData(data: dailyForecast.sun.rise).0):\(self.parsData.parsingData(data: dailyForecast.sun.rise).1)",
                                                  sunSet: "Sunset",
                                                  sSTime: "\(self.parsData.parsingData(data: dailyForecast.sun.set).0):\(self.parsData.parsingData(data: dailyForecast.sun.set).1)")]
            }
        }
        // MARK: - RELOAD DATA TV DAY TEMPER:
        fiveDayForecastService.fetchDayForecast(cityKey: 326175) { (fiveDayForecast) in
            print(fiveDayForecast)
            if let dailyForecast5 = fiveDayForecast.dailyForecasts.first {
                self.arrDayTemp = [ModelTVCellDay(dayName: "\(self.parsData.parsingData(data: dailyForecast5.date).2)",
                                                minTemp: dailyForecast5.temperature.minimum.value,
                                                maxTemp: dailyForecast5.temperature.maximum.value),
                                ModelTVCellDay(dayName: "\(self.parsData.parsingData(data: dailyForecast5.date).2)",
                                minTemp: dailyForecast5.temperature.minimum.value,
                                maxTemp: dailyForecast5.temperature.maximum.value),
                                ModelTVCellDay(dayName: "\(self.parsData.parsingData(data: dailyForecast5.date).2)",
                                minTemp: dailyForecast5.temperature.minimum.value,
                                maxTemp: dailyForecast5.temperature.maximum.value),
                                ModelTVCellDay(dayName: "\(self.parsData.parsingData(data: dailyForecast5.date).2)",
                                minTemp: dailyForecast5.temperature.minimum.value,
                                maxTemp: dailyForecast5.temperature.maximum.value),
                                ModelTVCellDay(dayName: "\(self.parsData.parsingData(data: dailyForecast5.date).2)",
                                minTemp: dailyForecast5.temperature.minimum.value,
                                maxTemp: dailyForecast5.temperature.maximum.value)]
            }
        }
        
        // MARK: - RELOAD DATA CV HOURS TEMPER:
//        twentyHoursForecastService.fetchDayForecast(cityKey: 326175) { (twentyHoursForecast) in
//                   print(twentyHoursForecast)
//            if let dailyForecast12 = twentyHoursForecast.dailyForecasts {
//                       self.arrSunRS = [ModelTVCellSunRS(sunRise: "Sunrise",
//                                                         sRTime: "\(self.parsData.parsingData(data: dailyForecast.sun.rise).0):\(self.parsData.parsingData(data: dailyForecast.sun.rise).1)",
//                                                         sunSet: "Sunset",
//                                                         sSTime: "\(self.parsData.parsingData(data: dailyForecast.sun.set).0):\(self.parsData.parsingData(data: dailyForecast.sun.set).1)")]
//                   }
        
        
    }
    
//    unc workWithDailyForecastData(_ data: [TwelveHoursForecastResponse]) -> Void {
//        responseDataForTwelveHours = data
//    }
    
    func workWithFiveDaysForecastData(_ data: ResponsFiveDayForecast) -> Void {
        responseDataForFiveDays = data
    }

    func workWithError(_ error: Error) -> Void {
        print(error)
    }

}



