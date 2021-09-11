//
//  SignupViewModel.swift
//  SignupViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import Foundation
import RxSwift
import RxCocoa


class SignupViewModel: SignupProtocol {

    private let disposeBag = DisposeBag()
    let userValidationService: UserValidationProtocol!
    

    let name: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let email: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let password: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let dob: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let gender: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let profilePic: BehaviorRelay<Data> = BehaviorRelay.init(value: Data())

    let showLogin: PublishSubject<Bool> = PublishSubject<Bool>()

    init(userValidationService: UserValidationProtocol = UserValidationService()) {
        self.userValidationService = userValidationService
    }
    
    func isValidUser() -> Observable<Bool> {
        return Observable.combineLatest(name.asObservable(), email.asObservable(), password.asObservable(), dob.asObservable(), gender.asObservable()).map { name, email, password, dob, gender in
            
            return (self.userValidationService.isValidName(name) && self.userValidationService.isValidEmail(email) && self.userValidationService.isValidPassword(password) && self.userValidationService.isValidDob(dob) && self.userValidationService.isValidGender(gender))
        }
    }
    
    
    func saveUserInDB() {
        
    }
 
    
    func signup() {
        
        if userValidationService.isValidUser() {
            showLogin.onNext(true)
        }
    
    }
}
