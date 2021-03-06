//
//  TabBarCoordinator.swift
//  TabBarCoordinator
//
//  Created by Dipak Pandey on 11/09/21.
//


import RxSwift
import UIKit


final class TabBarCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    private let user: User
    private var viewControllers: [UINavigationController]
    private var tabBarVC: TabBarViewController!
    
    init(user: User, navigationController: UINavigationController) {
        self.user = user
        self.navigationController = navigationController
        
        self.viewControllers = TabBarItems.allCases
            .map({ (item) -> UINavigationController in
                return item.navigationController
            })
    }

    
    override func start() -> Observable<Void> {
        tabBarVC = TabBarViewController.initFromStoryboard()
        tabBarVC.tabBar.isTranslucent = false
        tabBarVC.viewControllers = viewControllers
        self.navigationController.viewControllers.append(tabBarVC)
        
        let _ = viewControllers.enumerated()
            .map { (index, controller) -> Observable<Void> in
                guard let tabBarItem = TabBarItems(rawValue: index) else { return Observable.just(() )}
                
                switch tabBarItem {
                case .profile:
                    let profileCoordinater = ProfileCoordinator.init(user: user, navigationController: controller)
                                       
                    profileCoordinater.isLogout
                        .subscribe(onNext:
                                    { [weak self] _ in
                            self?.moveToLoginScreen()
                        })
                        .disposed(by: disposeBag)
                    
                    let coordinate = coordinate(to: profileCoordinater)
                    
                    coordinate
                        .subscribe()
                        .disposed(by: disposeBag)
                    
                    return coordinate
                    
                case .weather:
                    
                    let weatherCordinator = WeatherInfoCoordinator(navigationController: controller)
                    return coordinate(to: weatherCordinator)
                }
        }

        return Observable.empty()
    }
    
    private func moveToLoginScreen() {
        self.viewControllers.removeAll()
        tabBarVC.viewControllers?.removeAll()
        self.navigationController.popViewController(animated: true)
        tabBarVC = nil
    }
}

