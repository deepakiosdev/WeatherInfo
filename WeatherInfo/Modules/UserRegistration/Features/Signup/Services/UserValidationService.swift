//
//  UserValidationService.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 11/09/21.
//

import Foundation
import UIKit


struct UserValidationService: UserValidationProtocol {
    
    func isValidName(_ name: String) -> Bool {
        return name.count > 3
    }
    
    func isValidDob(_ dob: String) -> Bool {
        return dob.count > 7
    }
    
    func isValidGender(_ gender: String) -> Bool {
        return Gender.init(rawValue: gender.lowercased()) != nil
    }
    
    func isValidUser(_ user: User) -> Bool {
        
        if !isValidName(user.name ?? "") {
            showAlertWithMessage("Name should be more than 3 character")
            return false
        }
        
        if !isValidEmail(user.email ?? "") {
            showAlertWithMessage("Please enter valid email address")
            return false
        }
        
        if !isValidPassword(user.password ?? "") {
            showAlertWithMessage("Password should be more than 5 character")
            return false
        }
        
        if !isValidDob(user.dob ?? "") {
            showAlertWithMessage("Please enter valid date of birth")
            return false
        }
        
        if !isValidGender(user.gender ?? "") {
            showAlertWithMessage("Please enter valid gender")
            return false
        }
        
        return true
    }
    
    private func showAlertWithMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)


         // Add action buttons to it and attach handler functions if you want to

         alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        // Show the alert by presenting it
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController?.present(alert, animated: true)
    }
}
