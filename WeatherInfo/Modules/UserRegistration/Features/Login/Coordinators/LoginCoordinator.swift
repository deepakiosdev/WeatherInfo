//
//  LoginCoordinator.swift
//  LoginCoordinator
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

class LoginCoordinator: BaseCoordinator<Void> {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {
        let coreDataManager = CoreDataManager()
        let loginService = LoginService.init(managedObjectContext: coreDataManager.mainContext, coreDataStack: coreDataManager)
        let viewModel = LoginViewModel(loginService: loginService)
        let viewController = LoginViewController.initFromStoryboard()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.showSignup
            .subscribe(onNext:
                        { [weak self] in
                self?.showSignupScreen()
            })
            .disposed(by: disposeBag)
        
        viewModel.showHomeScreen
            .debug()
            .subscribe(onNext:
                        { [weak self] _ in
                self?.showTabBarScreen()
            })
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func showSignupScreen() {
        navigationController.popViewController(animated: true)
    }

    private func showTabBarScreen() {
        let tabBarCoordinator = TabBarCoordinator.init(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
