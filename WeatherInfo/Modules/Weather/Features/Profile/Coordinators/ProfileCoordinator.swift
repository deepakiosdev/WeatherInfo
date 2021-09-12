//
//  ProfileCoordinator.swift
//  ProfileCoordinator
//
//  Created by Dipak Pandey on 11/09/21.
//


import UIKit
import RxSwift

final class ProfileCoordinator: BaseCoordinator<Void> {
    private let navigationController: UINavigationController
    private let user: User
    var isLogout = PublishSubject<Bool>()

    init(user: User, navigationController: UINavigationController) {
        self.user = user
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = ProfileViewController.initFromStoryboard()
        let viewModel = ProfileViewModel(user: user)
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: true)
                
        viewModel.showLoginScreen
            .subscribe(onNext:
                        { [weak self] in
                self?.showLoginScreen()
            })
            .disposed(by: disposeBag)
        
        
        return Observable.empty()
    }
    
    private func showLoginScreen() {
        isLogout.onNext(true)
    }
}
