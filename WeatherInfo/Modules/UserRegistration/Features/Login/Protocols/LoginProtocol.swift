//
//  LoginProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation

protocol LoginProtocol: EmailPasswordValidationProtocol {
    func isValidCredential(_ email: String, password: String) -> Bool
    func login()
}
