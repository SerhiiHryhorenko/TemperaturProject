//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Admin on 19.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import Foundation

class SearchPresenter {

    weak var searchView: SerchViewControler?
    let searchService = CityNameServiceText()
    var searchResult = [ResponsSearchResult]() 
    
}
