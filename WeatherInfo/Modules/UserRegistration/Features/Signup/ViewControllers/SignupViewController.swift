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
    @IBOutlet weak var imgvProfilePic: UIImageView!
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfDob: UITextField!
    @IBOutlet weak var txfGender: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel: SignupViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    override func viewDidDisappear(_ animated: Bool) {
        clearData()
        self.view.endEditing(true)
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
        
    }
    
    //Clear text fields data and image
    private func clearData() {
        imgvProfilePic.image = nil
        txfName.text = ""
        txfEmail.text = ""
        txfPassword.text = ""
        txfDob.text = ""
        txfGender.text = ""
    }
    

}

extension SignupViewController {
    private func setupBindings() {

        // View Model outputs to the View Controller
        
//        if let imageData = imgvProfilePic.image?.pngData() {
//
//        }
//
        txfName.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        txfEmail.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        txfPassword.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        txfDob.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.dob)
            .disposed(by: disposeBag)
        txfGender.rx.text
            .map{$0 ?? ""}
            .bind(to: viewModel.gender)
            .disposed(by: disposeBag)

        btnSignup.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.signup()
            })
            .disposed(by: disposeBag)

        viewModel.isValidUser()
            .bind(to: btnSignup.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValidUser()
            .map {$0 ? 1 : 0.4}
            .bind(to: btnSignup.rx.alpha)
            .disposed(by: disposeBag)

    }
}
