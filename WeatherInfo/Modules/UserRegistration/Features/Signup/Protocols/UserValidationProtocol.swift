//
//  SignupServiceProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 11/09/21.
//

import Foundation

enum Gender: String {
    case male
    case female
    case other
}

protocol UserValidationProtocol: EmailPasswordValidationProtocol {
    func isValidName(_ name: String) -> Bool
    func isValidDob(_ dob: String) -> Bool
    func isValidGender(_ gender: String) -> Bool
    func isValidUser(_ user: User) -> Bool
}

