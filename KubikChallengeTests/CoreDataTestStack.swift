//
//  CoreDataTestStack.swift
//  KubikChallengeTests
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation
import CoreData
@testable import KubikChallenge

struct CoreDataTestStack {
    let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "KubikChallenge")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        container.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Unable to load store \(error!)")
            }
        }
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = container.persistentStoreCoordinator
    }
}
