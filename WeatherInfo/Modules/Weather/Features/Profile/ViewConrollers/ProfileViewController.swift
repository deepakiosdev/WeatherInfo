//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit
import RxSwift
import RxGesture

final class ProfileViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var imgvProfilePic: UIImageView!
    @IBOutlet weak var imgvEyeIcon: UIImageView!
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfDob: UITextField!
    @IBOutlet weak var txfGender: UITextField!
    @IBOutlet weak var btnLogout: UIButton!
    
    var viewModel: ProfileViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        let user = viewModel.user
       
        if let imageData = user.profilePic {
            imgvProfilePic.image = UIImage(data: imageData)
        }
        txfName.text = user.name ?? ""
        txfEmail.text = user.email ?? ""
        txfPassword.text = user.password ?? ""
        txfDob.text = user.dob ?? ""
        txfGender.text = user.gender?.capitalized ?? ""
        txfPassword.isSecureTextEntry = true
        imgvEyeIcon.image = UIImage(systemName: Constants.Image.eye)
        
    }
}


// MARK: - Binding

extension ProfileViewController {
    
    private func setupBindings() {
        
        btnLogout.rx.tap
            .bind(to: viewModel.showLoginScreen)
            .disposed(by: disposeBag)
        
        imgvEyeIcon.rx
            .tapGesture()
            .subscribe(onNext: { [weak self]_ in
                guard let self = self else {
                    return
                }
                let isSecure = self.txfPassword.isSecureTextEntry
                self.txfPassword.isSecureTextEntry = !isSecure
                self.imgvEyeIcon.image = UIImage(systemName: isSecure ? Constants.Image.eyeSlash : Constants.Image.eye)

            }).disposed(by: disposeBag)
        
    }
}
