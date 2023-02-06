//
//  FavoritesManager.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation
import CoreData

struct FavoritesManager {
    
    let mainContext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataStack.sharedInstance.mainContext) {
        self.mainContext = mainContext
    }
    
    func isFavorite(restaurantUUID: String) -> Bool {
        let request: NSFetchRequest<Favorite> = NSFetchRequest(entityName: "Favorite")
        var isFavorite = Bool()
        
        do {
            let favs = try mainContext.fetch(request)
            for i in 0..<favs.count {
                if restaurantUUID == favs[i].restaurantUUID {
                    isFavorite = favs[i].isFavorite
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return isFavorite
    }
    
    func saveFavorite(restaurantUUID: String) {
        let favorite = Favorite(context: mainContext)
        favorite.restaurantUUID = restaurantUUID
        favorite.isFavorite = true
        
        do {
            try mainContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
