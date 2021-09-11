//
//  SignupViewController.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel: SignupViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {
    }

    private func setupBindings() {

        // View Model outputs to the View Controller
        btnSignup.rx.tap
            .bind(to: viewModel.showLogin)
            .disposed(by: disposeBag)


    }

}

