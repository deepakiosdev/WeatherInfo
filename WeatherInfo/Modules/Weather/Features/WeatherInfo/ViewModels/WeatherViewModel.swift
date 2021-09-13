//
//  WeatherViewModel.swift
//  WeatherViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherViewModelProtocol {
    func fetchLocation()
    func fetchWetherDetail(for location: Location)
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private let locationService: LocationServiceProtocol!
    private let weatherForecastService: WeatherForecastNetworkServiceProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - Output
    let isFetchingData: BehaviorRelay<Bool> = BehaviorRelay.init(value: true)
    let hasError: BehaviorRelay<Bool> = BehaviorRelay.init(value: false)
    let processMessage: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let location: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let temperature: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let weatherDescription: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let maxTemp: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let minTemp: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let humdity: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let windSpeed: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let forecasts: BehaviorRelay<[ForecastCellViewModel]> = BehaviorRelay<[ForecastCellViewModel]>.init(value: [ForecastCellViewModel]())

    
    init(locationService: LocationServiceProtocol = LocationService(), weatherForecastService: WeatherForecastNetworkServiceProtocol) {
        self.locationService = locationService
        self.weatherForecastService = weatherForecastService
        fetchLocation()
    }
   
    func fetchLocation() {
        isFetchingData.accept(true)
        locationService.getCurrentLocation() { [weak self] (location, error) in            
            guard let location = location else {
                self?.isFetchingData.accept(false)
                return
            }
            self?.fetchWetherDetail(for: location)
        }
    }
    
    func fetchWetherDetail(for location: Location) {
        
        do{
            try weatherForecastService.fetchWeatherForecast(for: location)
                .throttle(.seconds(5), scheduler: MainScheduler.instance)
                .subscribe(
                onNext: { [weak self] weatherForcast in
                    print(weatherForcast.cityName)
                    self?.update(weatherForcast)
                },
                onError: { [weak self] error in
                    print(error.localizedDescription)
                    self?.handleError(WAError.networkRequestFailed)
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch {
            handleError(WAError.networkRequestFailed)
        }
    }
}

// MARK: - Data formatting and response handling

extension WeatherViewModel {
    
    private func update(_ weather: WeatherForecastModel) {
        processMessage.accept("")
        location.accept(weather.cityName + ", \(weather.country)")

        guard let currentWeather = weather.weaterDetails.first else {
            handleError(WAError.noData)
            return
        }
        
        temperature.accept("\(currentWeather.currentTemperature) °C")
        weatherDescription.accept(currentWeather.description.capitalized)
        maxTemp.accept("\(currentWeather.maxTemperature) °C")
        minTemp.accept("\(currentWeather.minTemperature) °C")
        humdity.accept("\(currentWeather.humidity) %")
        windSpeed.accept("\(currentWeather.windSpeed) meter/sec")

        //Construct Froecast data model. Drop first WeatherDetail object from forecast model array because it represnts current time weather condition
        constructForecastDataModel(fromWeatherDetails: Array(weather.weaterDetails.dropFirst()))
        hasError.accept(false)
        isFetchingData.accept(false)

    }
    
    
    private func handleError(_ error: WAError) {
        hasError.accept(true)
        processMessage.accept(error.description)

        location.accept("")
        temperature.accept("")
        weatherDescription.accept("")
        maxTemp.accept("")
        minTemp.accept("")
        humdity.accept("")
        windSpeed.accept("")

        self.forecasts.accept([ForecastCellViewModel]())
        isFetchingData.accept(false)
        hasError.accept(true)
    }
    
    private func constructForecastDataModel(fromWeatherDetails weatherDetails: [WeatherDetail]) {
        
        if (weatherDetails.count > 0) {
            let tempForecasts = weatherDetails.map { forecast in
                return ForecastCellViewModel.init(forecast.dateTime, temperature: String(forecast.currentTemperature), description: forecast.description)
            }
            forecasts.accept(tempForecasts)
        } else {
            self.forecasts.accept([ForecastCellViewModel]())
        }
    }
}
