//
//  SignupViewModel.swift
//  SignupViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import Foundation
import RxSwift

class SignupViewModel {
    private let disposeBag = DisposeBag()

    let showLogin: PublishSubject<Void> = PublishSubject<Void>()
    
    
    init() {
    }

}
