//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var btnLogout: UIButton!
    
    var viewModel :ProfileViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


  
    private func setupUI() {
    }

    private func setupBindings() {

        // View Model outputs to the View Controller
        btnLogout.rx.tap
            .bind(to: viewModel.showLoginScreen)
            .disposed(by: disposeBag)


    }
}
