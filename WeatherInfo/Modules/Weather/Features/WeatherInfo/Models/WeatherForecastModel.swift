//
//  WeatherForecastModel.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation

struct WeatherForecastModel {

    let cityName: String
    let country: String
    let weaterDetails : [WeatherDetail]
    
    private enum CodingKeys: String, CodingKey {
        case city
        case weaterDetails = "list"
    }
    
    enum CityKeys: String, CodingKey {
        case cityName = "name"
        case country
    }
}

extension WeatherForecastModel: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weaterDetails = try values.decodeIfPresent([WeatherDetail].self, forKey: .weaterDetails) ?? []
        
        let cityValues = try values.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        cityName = try cityValues.decodeIfPresent(String.self, forKey: .cityName) ?? ""
        country = try cityValues.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
    
}


struct WeatherDetail {
    
    let dateTime: String
    var description = ""
    let currentTemperature: Float
    let maxTemperature: Float
    let minTemperature: Float
    let humidity: Float
    let windSpeed: Float

    
    private enum CodingKeys: String, CodingKey {
        case dateTime = "dt_txt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
    
    enum WeatherKeys: String, CodingKey {
        case description
    }
    
    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
    }
    
}

extension WeatherDetail: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime) ?? ""

        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        currentTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .currentTemperature) ?? 0.0
        minTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .minTemperature) ?? 0.0
        maxTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .maxTemperature) ?? 0.0
        humidity = try mainValues.decodeIfPresent(Float.self, forKey: .humidity) ?? 0.0
     
        var weatherValues = try values.nestedUnkeyedContainer(forKey:.weather)

        while (!weatherValues.isAtEnd) {
            let weatherInfo = try weatherValues.nestedContainer(keyedBy: WeatherKeys.self)
            description = try weatherInfo.decodeIfPresent(String.self, forKey: .description) ?? ""
        }
        
        let windValues = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windValues.decodeIfPresent(Float.self, forKey: .windSpeed) ?? 0.0
    }
    
}
