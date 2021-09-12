//
//  ProfileViewModel.swift
//  ProfileViewModel
//
//  Created by Dipak Pandey on 10/09/21.
//

import RxSwift

final class ProfileViewModel {
    private let disposeBag = DisposeBag()
    let user: User
    let showLoginScreen: PublishSubject<Void> = PublishSubject<Void>()

    init(user: User) {
        self.user = user
    }
}
