//
//  LoginCoordinator.swift
//  LoginCoordinator
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

final class LoginCoordinator: BaseCoordinator<Void> {
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
            .subscribe(onNext:
                        { [weak self] user in
                            self?.showTabBarScreen(for: user)
                        })
            .disposed(by: disposeBag)
        
        return Observable.empty()
    }
    
    private func showSignupScreen() {
        navigationController.popViewController(animated: true)
    }
    
    private func showTabBarScreen(for user: User) {
        let tabBarCoordinator = TabBarCoordinator.init(user: user, navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
