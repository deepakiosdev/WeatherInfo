//
//  WeatherInfoCoordinator.swift
//  WeatherInfoCoordinator
//
//  Created by Dipak Pandey on 11/09/21.
//

import UIKit
import RxSwift

final class WeatherInfoCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let networkManager = NetworkManager()
        let service = WeatherForecastService(networkManager: networkManager)
        let viewModel = WeatherViewModel(weatherForecastService: service)
        let viewController = WeatherViewController.initFromStoryboard()
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: true)
        return Observable.empty()
    }
    
}
