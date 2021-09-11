//
//  ProfileViewModel.swift
//  ProfileViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import RxSwift

class ProfileViewModel {
    private let disposeBag = DisposeBag()

    let showLoginScreen: PublishSubject<Void> = PublishSubject<Void>()

    init() {
        
    }
}
