//
//  UserDatabaseService.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import CoreData



final class UserDatabaseService: UserDatabaseProtocol {
  // MARK: - Properties
  let managedObjectContext: NSManagedObjectContext
  let coreDataManager: CoreDataManager

  // MARK: - Initializers
   init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataManager) {
    self.managedObjectContext = managedObjectContext
    self.coreDataManager = coreDataStack
  }
}

// MARK: - Public
extension UserDatabaseService {
    
    func initUser(_ profilePic: Data?, name: String, email: String, password: String, dob: String, gender: String) -> User {
        let user = User(context: managedObjectContext)

        user.profilePic = profilePic
        user.name = name
        user.email = email
        user.password = password
        user.dob = dob
        user.gender = gender
        
        return user
    }
    
    @discardableResult
    func saveUser(_ user: User) -> User {
        deleteUsers()
        coreDataManager.saveContext(managedObjectContext)
        
        return user
    }
    
    func deleteUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Core data delete error:\(error)")
        }
        coreDataManager.saveContext(managedObjectContext)
    }
    
    
}
