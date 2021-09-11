//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

}

// MARK: - Binding

extension LoginViewController {
    private func setupBindings() {

        // View Model outputs to the View Controller

        txfEmail.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        txfPassword.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        btnLogin.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.login()
            })
            .disposed(by: disposeBag)

        viewModel.isValidLoginInfo()
            .map {$0 ? 1 : 0.4}
            .bind(to: btnLogin.rx.alpha)
            .disposed(by: disposeBag)

        btnSignup.rx.tap
            .bind(to: viewModel.showSignup)
            .disposed(by: disposeBag)
        

    }
}
