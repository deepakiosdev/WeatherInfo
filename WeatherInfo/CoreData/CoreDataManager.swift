//
//  CoreDataManager.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let modelName = "WeatherInfo"
    
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    init() {
    }
    
    lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.modelName, managedObjectModel: CoreDataManager.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
    
    func saveContext() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            if context != mainContext {
                saveDerivedContext(context)
                return
            }
            
            context.perform {
                do {
                    try context.save()
                } catch let error as NSError {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    
    func saveDerivedContext(_ context: NSManagedObjectContext) {
       
        if context.hasChanges {
            
            context.perform {
                do {
                    try context.save()
                } catch let error as NSError {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                
                self.saveContext(self.mainContext)
            }
        }
    }
}
