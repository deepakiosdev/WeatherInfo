//
//  LoginViewModel.swift
//  LoginViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let loginService: LoginProtocol!

    let email: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let password: BehaviorRelay<String> = BehaviorRelay.init(value: "")

    let showSignup: PublishSubject<Void> = PublishSubject<Void>()
    let showHomeScreen: PublishSubject<Bool> = PublishSubject<Bool>()

    init(loginService: LoginProtocol) {
        self.loginService = loginService
    }
    
    func isValidLoginInfo() -> Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()).map { email, password in
            return (self.loginService.isValidEmail(email) && self.loginService.isValidPassword(password))
        }
    }

    func login() {
        
        if loginService.isValidCredential(email.value, password: password.value) {
            showHomeScreen.onNext(true)
        }
    }
        
}
