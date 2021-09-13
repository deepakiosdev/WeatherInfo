//
//  ForecastCellViewModel.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation


struct ForecastCellViewModel {
    
    let dateTime: String
    let temperature: String
    let description: String
    
    init(_ dateTime: String, temperature: String, description: String) {
        //Get formated date string from soruce date string
        let dateTimeSting = DateUtility(date: dateTime).forcastDateTimeString
        self.dateTime = dateTimeSting
        self.temperature = ("\(temperature) °C")
        self.description = description.capitalized
    }
}
