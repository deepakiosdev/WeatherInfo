//
//  LoginViewModel.swift
//  LoginViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import RxSwift

class LoginViewModel {
    private let disposeBag = DisposeBag()

    let showSignup: PublishSubject<Void> = PublishSubject<Void>()
    let showHomeScreen: PublishSubject<Void> = PublishSubject<Void>()

    init() {
        
    }
}
