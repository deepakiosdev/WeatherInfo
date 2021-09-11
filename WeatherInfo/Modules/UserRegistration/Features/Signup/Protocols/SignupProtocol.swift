//
//  SignupProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 11/09/21.
//

import Foundation

import RxSwift
import RxCocoa

protocol SignupProtocol {
    func saveUserInDB(_ user: User)
    func signup()
}
