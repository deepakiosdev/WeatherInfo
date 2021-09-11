//
//  LoginService.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import UIKit
import CoreData

struct LoginService: LoginProtocol {
    
    // MARK: - Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataManager: CoreDataManager

    // MARK: - Initializers
     init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataManager) {
      self.managedObjectContext = managedObjectContext
      self.coreDataManager = coreDataStack
    }
}

extension LoginService {
    
    func isValidCredential(_ email: String, password: String) -> Bool {
        
        guard let user = getUser() else {
            return false
        }
        
        if email == user.email && password == user.password {
            return true
        }
        showAlertWithMessage("Please enter valid credential")

        return false
    }
    
    func login() {
        
    }
    
   private func getUser() -> User? {
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(userFetch)
            return results.first
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }

}

extension LoginService {
    
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
