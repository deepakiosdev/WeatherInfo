//
//  WeatherViewModel.swift
//  WeatherViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import Foundation
import RxSwift

protocol WeatherViewModelProtocol {
    func fetchLocation()
    func fetchWetherDetail(for location: Location)
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private let locationService: LocationServiceProtocol!
    private let weatherForecastService: WeatherForecastNetworkServiceProtocol!
    private let disposeBag = DisposeBag()

    init(locationService: LocationServiceProtocol = LocationService(), weatherForecastService: WeatherForecastNetworkServiceProtocol) {
        self.locationService = locationService
        self.weatherForecastService = weatherForecastService
        fetchLocation()
    }
   
    func fetchLocation() {
        locationService.getCurrentLocation() { [weak self] (location, error) in            
            guard let location = location else {
                return
            }
            
            self?.fetchWetherDetail(for: location)

        }
    }
    
    func fetchWetherDetail(for location: Location) {
        
        do{
            try weatherForecastService.fetchWeatherForecast(for: location).subscribe(
                onNext: { weatherForcast in
                    print(weatherForcast.cityName)
                },
                onError: { error in
                    print(error.localizedDescription)
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch {
        }
    }
}

