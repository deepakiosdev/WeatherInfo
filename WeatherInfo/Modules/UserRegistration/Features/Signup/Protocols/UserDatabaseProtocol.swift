//
//  UserDatabaseProtocol.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation


protocol UserDatabaseProtocol {
    func initUser(_ profilePic: Data?, name: String, email: String, password: String, dob: String, gender: String) -> User
    @discardableResult func saveUser(_ user: User) -> User
    func deleteUsers()
}
