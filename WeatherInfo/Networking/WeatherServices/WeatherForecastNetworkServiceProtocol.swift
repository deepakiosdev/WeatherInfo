//
//  WeatherForecastNetworkServiceProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import RxSwift

protocol WeatherForecastNetworkServiceProtocol {
    func fetchWeatherForecast(for location: Location) throws -> Observable<WeatherForecastModel>
}

struct WeatherForecastService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension WeatherForecastService: WeatherForecastNetworkServiceProtocol {
    
    func fetchWeatherForecast(for location: Location) throws -> Observable<WeatherForecastModel> {
        return networkManager.fetch(using: try NetworkRequest.weatherForecast(location).urlRequest())
        
    }
}

