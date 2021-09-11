//
//  UserValidationService.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 11/09/21.
//

import Foundation


struct UserValidationService: UserValidationProtocol {
    
    func isValidName(_ name: String) -> Bool {
        return name.count > 3
    }
    func isValidEmail(_ email: String) -> Bool {
        return email.count > 8 && email.contains("@") && email.contains(".")
    }
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 6
    }
    func isValidDob(_ dob: String) -> Bool {
        return dob.count > 7
    }
    
    func isValidGender(_ gender: String) -> Bool {
        return Gender.init(rawValue: gender.lowercased()) != nil
    }
    
    func isValidUser() -> Bool {
        
        return true
    }
}
