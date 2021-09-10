//
//  AppCoordinator.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = UIColor.white
    }
    
    override func start() -> Observable<CoordinationResult> {
        let registrationCoordinator = UserRegistrationCoordinator(window: window)
        return self.coordinate(to: registrationCoordinator)
    }
}
