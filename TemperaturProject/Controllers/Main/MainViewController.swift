//
//  ViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 05.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableViewDay: UITableView!
    @IBOutlet weak var collectionViewDay: UICollectionView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempCityNameLabel: UILabel!
    
    public var locationKey = 326175
    
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
    
    private let cityNameServise = CityNameService()
    private let oneDayForecastService = OneDayForecastService()
    private let fiveDayForecastService = FiveDayForecastService()
    private let twentyHoursForecastService = TwentyHoursForecastService()
    
    private var cityName: String? {
        didSet {
            DispatchQueue.main.async {
                self.cityNameLabel.text = self.cityName
            }
        }
    }
    
    var arrayTimeCV = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionViewDay.reloadData()
            }
        }
    }
    var arrayTemperCV = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionViewDay.reloadData()
            }
        }
    }
    
    var arrSunRS: [ModelTVCellSunRS] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewDay.reloadData()
            }
        }
    }
    
    var arrDayTemp: [ModelTVCellDay] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewDay.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        // MARK: - RELOAD CITY Name:
        cityNameServise.fetchCityName(cityKey: locationKey) { (cityName) in
            self.cityName = cityName.localizedName
        }
        
        // MARK: - RELOAD DATA TV SUN RISE_SET:
        oneDayForecastService.fetchDayForecast(cityKey: locationKey) { (oneDayForecast) in
            print(oneDayForecast)
            if let dailyForecast = oneDayForecast.dailyForecasts.first {
                self.currentTemperature = dailyForecast.temperature.maximum.value
                
                let sunriseHours = DateParser.parsDate(dailyForecast.sun.rise).hour
                let sunriseMinutes = DateParser.parsDate(dailyForecast.sun.rise).minute
                let sunriseTime = "\(sunriseHours):\(sunriseMinutes)"
                
                let sunsetHours = DateParser.parsDate(dailyForecast.sun.set).hour
                let sunsetMinutes = DateParser.parsDate(dailyForecast.sun.set).minute
                // TODO: finish
                let sunsetTime = "\(sunsetHours):\(sunsetMinutes)"
                
                let sunInfo = ModelTVCellSunRS(sunRise: "Sunrise", sRTime: sunriseTime, sunSet: "Sunset", sSTime: sunsetTime)
                
                self.arrSunRS = [sunInfo]
            }
        }
        // MARK: - RELOAD DATA TV DAY TEMPER:
        fiveDayForecastService.fetchDayForecast(cityKey: locationKey) { (fiveDayForecast) in
            print(fiveDayForecast)
            for dailyForecast5 in fiveDayForecast.dailyForecasts {
                // TODO: do like at 67 - 80 lines
                self.arrDayTemp.append(ModelTVCellDay(dayName: "\(DateParser.parsDate(dailyForecast5.date).day)",
                    minTemp: dailyForecast5.temperature.minimum.value,
                    maxTemp: dailyForecast5.temperature.maximum.value))
            }
        }
        
        // MARK: - RELOAD DATA CV HOURS TEMPER:
        twentyHoursForecastService.fetchDayForecast(cityKey: locationKey) { (twentyHoursForecast) in
            print(twentyHoursForecast)
            for dailyForecast12 in twentyHoursForecast {
                let hour = "\(DateParser.parsDate(dailyForecast12.dateTime).hour)"
                let timeColView = "\(hour):00"
                let maxTemperature = "\(dailyForecast12.temperature.value)"
                
                self.arrayTimeCV.append(timeColView)
                self.arrayTemperCV.append(maxTemperature)
            }
        }
    }
}

//MARK: - create CollectionViewCell
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTimeCV.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCVTemp", for: indexPath) as! CellCollView
        collectionViewCell.hourCVLabel.text = "\( arrayTimeCV[indexPath.row])"
        collectionViewCell.tempCVLabel.text = "\(arrayTemperCV[indexPath.row])"
        //collectionViewCell.backgroundColor = .clear
        return collectionViewCell
    }
    
}

