//
//  Location.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import CoreLocation

struct Location {
    var latitude: String
    var longitude: String
}

extension Location {
    
    init(location: CLLocation) {
        latitude = String(location.coordinate.latitude)
        longitude = String(location.coordinate.longitude)
    }
}
