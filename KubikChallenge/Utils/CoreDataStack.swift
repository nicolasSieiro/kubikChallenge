//
//  CoreDataStack.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    static let sharedInstance = CoreDataStack()
    
    let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "KubikChallenge")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading core data - \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        
        mainContext = container.viewContext
    }
}
