//
//  ProfileCoordinator.swift
//  ProfileCoordinator
//
//  Created by Dipak Pandey on 11/09/21.
//


import UIKit
import RxSwift

class ProfileCoordinator: BaseCoordinator<Void> {
    var isLogout = PublishSubject<Bool>()
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = ProfileViewController.initFromStoryboard()
        let viewModel = ProfileViewModel()
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
