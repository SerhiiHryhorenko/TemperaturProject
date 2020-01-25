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
//    public cities: [String] = []
    
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
    private let cityTimeZone = CityTimeZone()
    
    private var timeZone: String?
    
    private var cityName: String? {
        didSet {
            DispatchQueue.main.async {
                self.cityNameLabel.text = self.cityName
            }
        }
    }
    
    private var cityTemper: String? {
        didSet {
            DispatchQueue.main.async {
                self.tempCityNameLabel.text = self.cityTemper
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
    
    private func v(_a: Int) -> String{
        if _a / 10 == 0 {
            return ("0\(_a)")
        } else {
            return ("\(_a)")
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - RELOAD CITY Name:
        cityNameServise.fetchCityName(cityKey: locationKey) { (cityName) in
            self.cityName = cityName.localizedName
        }
        
        // MARK: - RELOAD DATA TV SUN RISE_SET:
        oneDayForecastService.fetchDayForecast(cityKey: locationKey) { (oneDayForecast) in
            self.cityTimeZone.fetchTimeZone(cityKey: self.locationKey) { (tz) in
                
//                self.timeZone = tz.timeZone.name
                
                if let dailyForecast = oneDayForecast.dailyForecasts.first {
                    self.currentTemperature = dailyForecast.temperature.maximum.value
                    let forecastDateRise = DateParser.parsDate(dailyForecast.sun.rise, timeZoneId: tz.timeZone.name)
                    let forecastDateSet = DateParser.parsDate(dailyForecast.sun.set, timeZoneId: tz.timeZone.name)
                    
                    let sunriseHours = self.v(_a: forecastDateRise.hour)
                    let sunriseMinutes = self.v(_a: forecastDateRise.minute)
                    let sunriseTime = "\(sunriseHours):\(sunriseMinutes)"
                    
                    let sunsetHours = self.v(_a: forecastDateSet.hour)
                    let sunsetMinutes = self.v(_a: forecastDateSet.minute)
                    let sunsetTime = "\(sunsetHours):\(sunsetMinutes)"
                    
                    let sunInfo = ModelTVCellSunRS(sunRise: "Sunrise", sRTime: sunriseTime, sunSet: "Sunset", sSTime: sunsetTime)
                    
                    self.arrSunRS = [sunInfo]
                }
                
                // MARK: - RELOAD DATA TV DAY TEMPER:
                self.fiveDayForecastService.fetchDayForecast(cityKey: self.locationKey) { (fiveDayForecast) in
                    
                    var arrDayTempNew: [ModelTVCellDay] = []
                    
                    for dailyForecast5 in fiveDayForecast.dailyForecasts {
                        let day = DateParser.parsDate(dailyForecast5.date, timeZoneId: tz.timeZone.name).day
                        let modelDay = ModelTVCellDay(dayName: "\(day)", minTemp: dailyForecast5.temperature.minimum.value, maxTemp: dailyForecast5.temperature.maximum.value)
                        arrDayTempNew.append(modelDay)
                    }
                    self.arrDayTemp = arrDayTempNew
                }
                
                // MARK: - RELOAD DATA CV HOURS TEMPER:
                self.twentyHoursForecastService.fetchDayForecast(cityKey: self.locationKey) { (twentyHoursForecast) in
                    //print(twentyHoursForecast)
                    
                    var hours: [String] = []
                    var temperatures: [String] = []
                    
                    for dailyForecast12 in twentyHoursForecast {
                        let hour = "\(DateParser.parsDate(dailyForecast12.dateTime, timeZoneId: tz.timeZone.name).hour)"
                        let timeColView = "\(hour):00"
                        let maxTemperature = "\(dailyForecast12.temperature.value)"
                        
                        hours.append(timeColView)
                        temperatures.append(maxTemperature)
                    }
                    
                    self.arrayTimeCV = hours
                    self.arrayTemperCV = temperatures
                }
            }
        }
    }
    
    @IBAction func pushListVCAction(_ sender: Any) {
        let _ = UIStoryboard(name: "Main", bundle: nil)
        
        if let mainVC = storyboard!.instantiateViewController(withIdentifier: "ListCityViewController") as? ListCityViewController {
            mainVC.delegate = self
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    func selectCityFromSearch(city: ResponsSearchResult) {
        //        cityNameLabel.text = city.cityName
        if let key = Int(city.key) {
            locationKey = key
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

        if indexPath.row == 0 {
            collectionViewCell.hourCVLabel.text = "now"
        }
        else {
            collectionViewCell.hourCVLabel.text = "\( arrayTimeCV[indexPath.row])"
        }
        tempCityNameLabel.text = "\(arrayTemperCV[0])"
        
        //collectionViewCell.hourCVLabel.text = "\( arrayTimeCV[indexPath.row])"
        collectionViewCell.tempCVLabel.text = "\(arrayTemperCV[indexPath.row])"
       
        return collectionViewCell
    }
    
}

