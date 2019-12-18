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
    private let cityTimeZone = CityTimeZone()
    
    private var timeZone: Double? {
        didSet {
            DispatchQueue.main.async {
                _ = self.timeZone
            }
        }
    }
    
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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        // MARK: - RELOAD CITY Name:
        cityNameServise.fetchCityName(cityKey: locationKey) { (cityName) in
            self.cityName = cityName.localizedName
        }
        
        cityTimeZone.fetchTimeZone(cityKey: locationKey) { (tz) in
            self.timeZone = tz.gmtOffset
            print (tz.gmtOffset)
        }
        
        
        // MARK: - RELOAD DATA TV SUN RISE_SET:
        oneDayForecastService.fetchDayForecast(cityKey: locationKey) { (oneDayForecast) in
            //print(oneDayForecast)
            if let dailyForecast = oneDayForecast.dailyForecasts.first {
                self.currentTemperature = dailyForecast.temperature.maximum.value
                
                let sunriseHours = DateParser.parsDate(dailyForecast.sun.rise).hour
                let sunriseMinutes = DateParser.parsDate(dailyForecast.sun.rise).minute
                let sunriseTime = "\(sunriseHours):\(sunriseMinutes)"
                
                let sunsetHours = DateParser.parsDate(dailyForecast.sun.set).hour
                let sunsetMinutes = DateParser.parsDate(dailyForecast.sun.set).minute
                let sunsetTime = "\(sunsetHours):\(sunsetMinutes)"
                
                let sunInfo = ModelTVCellSunRS(sunRise: "Sunrise", sRTime: sunriseTime, sunSet: "Sunset", sSTime: sunsetTime)
                
                self.arrSunRS = [sunInfo]
            }
        }
        // MARK: - RELOAD DATA TV DAY TEMPER:
        fiveDayForecastService.fetchDayForecast(cityKey: locationKey) { (fiveDayForecast) in
            //print(fiveDayForecast)
            
            var arrDayTempNew: [ModelTVCellDay] = []
            
            for dailyForecast5 in fiveDayForecast.dailyForecasts {
                let modelDay = ModelTVCellDay(dayName: "\(DateParser.parsDate(dailyForecast5.date).day)", minTemp: dailyForecast5.temperature.minimum.value, maxTemp: dailyForecast5.temperature.maximum.value)
                arrDayTempNew.append(modelDay)
            }
            self.arrDayTemp = arrDayTempNew
        }
        
        // MARK: - RELOAD DATA CV HOURS TEMPER:
        twentyHoursForecastService.fetchDayForecast(cityKey: locationKey) { (twentyHoursForecast) in
            //print(twentyHoursForecast)
            
            var hours: [String] = []
            var temperatures: [String] = []
            
            for dailyForecast12 in twentyHoursForecast {
                let hour = "\(DateParser.parsDate(dailyForecast12.dateTime).hour)"
                let timeColView = "\(hour):00"
                let maxTemperature = "\(dailyForecast12.temperature.value)"
                
                hours.append(timeColView)
                temperatures.append(maxTemperature)
            }
            
            self.arrayTimeCV = hours
            self.arrayTemperCV = temperatures
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
        //guard indexPath.row != 0 else { return collectionViewCell.hourCVLabel.text = "now" as String}
        collectionViewCell.hourCVLabel.text = "\( arrayTimeCV[indexPath.row])"
        collectionViewCell.tempCVLabel.text = "\(arrayTemperCV[indexPath.row])"
        //collectionViewCell.backgroundColor = .clear
        return collectionViewCell
    }
    
}

