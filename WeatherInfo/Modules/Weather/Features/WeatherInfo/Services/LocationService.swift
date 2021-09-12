//
//  LocationService.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import CoreLocation


protocol LocationServiceProtocol {
    typealias locationCompletionHandler = (Location?, WAError?) -> Void
    func getCurrentLocation(completionHandler: @escaping locationCompletionHandler)
}

final class LocationService: NSObject, LocationServiceProtocol {
    var locationHandler: locationCompletionHandler?
    
    fileprivate let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func getCurrentLocation(completionHandler: @escaping (Location?, WAError?) -> Void) {
        locationHandler = completionHandler
        requestLocation()
     }

}

// MARK: - CLLocationManager Delegate
extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            locationHandler?(Location.init(location: location), nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in location finding: \(error.localizedDescription)")
        locationHandler?(nil, WAError.unableToFindLocation)
    }
}
