//
//  EmailPasswordValidationProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation


protocol EmailPasswordValidationProtocol {
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
}

extension EmailPasswordValidationProtocol {
    
    func isValidEmail(_ email: String) -> Bool {
        return email.count > 8 && email.contains("@") && email.contains(".")
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 5
    }
    
}
