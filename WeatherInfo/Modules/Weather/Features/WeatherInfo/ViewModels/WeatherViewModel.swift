//
//  WeatherViewModel.swift
//  WeatherViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import Foundation

protocol WeatherViewModelProtocol {
    func fetchLocation()
    //func fetchWetherDetail(for location: CLLocation)
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private let locationService: LocationServiceProtocol!
    
     init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
        fetchLocation()
    }
   
    func fetchLocation() {
        locationService.getCurrentLocation() { (location, error) in
            print("Location:\(String(describing: location))")
            print("Location error:\(String(describing: error))")
        }
    }
}

