//
//  SignupViewModel.swift
//  SignupViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import RxSwift
import RxCocoa


final class SignupViewModel: SignupProtocol {

    private let disposeBag = DisposeBag()
    private let userValidationService: UserValidationProtocol!
    private var userDatabaseService: UserDatabaseProtocol!

    let name: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let email: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let password: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let dob: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let gender: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    var profilePic: Data?
    
    let showLogin: PublishSubject<Bool> = PublishSubject<Bool>()

    init(userValidationService: UserValidationProtocol = UserValidationService(), userDatabaseService: UserDatabaseProtocol) {
        self.userValidationService = userValidationService
        self.userDatabaseService = userDatabaseService
    }
    
    func isValidUserInfo() -> Observable<Bool> {
        return Observable.combineLatest(name.asObservable(), email.asObservable(), password.asObservable(), dob.asObservable(), gender.asObservable()).map { name, email, password, dob, gender in
            
            return (self.userValidationService.isValidName(name) && self.userValidationService.isValidEmail(email) && self.userValidationService.isValidPassword(password) && self.userValidationService.isValidDob(dob) && self.userValidationService.isValidGender(gender))
        }
    }
    
    
    func saveUserInDB(_ user: User) {
        userDatabaseService.saveUser(user)
    }
 
    func signup() {
        
        let user = userDatabaseService.initUser(profilePic, name: name.value, email: email.value, password: password.value, dob: dob.value, gender: gender.value)

        if userValidationService.isValidUser(user) {
            saveUserInDB(user)
            showLogin.onNext(true)
        }
    
    }
}
