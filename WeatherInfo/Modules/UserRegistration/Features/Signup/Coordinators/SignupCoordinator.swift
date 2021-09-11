//
//  SignupCoordinator.swift
//  SignupCoordinator
//
//  Created by Dipak Pandey on 10/09/21.
//


import UIKit
import RxSwift

class SignupCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let viewModel = SignupViewModel()
        let viewController = SignupViewController.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: true)
        viewController.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.showLogin
            .subscribe(onNext:
                        { [weak self] _ in
                            self?.showLoginScreen()
                        })
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    
    private func showLoginScreen() {
        let loginCoordinator = LoginCoordinator.init(navigationController: window.rootViewController! as! UINavigationController)
        coordinate(to: loginCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }

}
