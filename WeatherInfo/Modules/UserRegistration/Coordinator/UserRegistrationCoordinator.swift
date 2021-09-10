//
//  UserRegistrationCoordinator.swift
//  UserRegistrationCoordinator
//
//  Created by Dipak Pandey on 10/09/21.
//


import UIKit
import RxSwift

class UserRegistrationCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let viewModel = SignupViewModel()
        let viewController = SignupViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewModel = viewModel

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }
}
