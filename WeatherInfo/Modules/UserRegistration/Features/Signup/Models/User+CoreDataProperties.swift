//
//  User+CoreDataProperties.swift
//  
//
//  Created by Dipak Pandey on 12/09/21.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var profilePic: Data?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var dob: String?
    @NSManaged public var gender: String?

}
