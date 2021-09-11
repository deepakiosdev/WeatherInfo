//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel: LoginViewModel!
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
        btnLogin.rx.tap
            .bind(to: viewModel.showHomeScreen)
            .disposed(by: disposeBag)

        btnSignup.rx.tap
            .bind(to: viewModel.showSignup)
            .disposed(by: disposeBag)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
