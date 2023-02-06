//
//  KubikChallengeTests.swift
//  KubikChallengeTests
//
//  Created by nicolas sieiro on 06/02/2023.
//

import XCTest
@testable import KubikChallenge

final class CoreDataTests: XCTestCase {
    
    var favoritesManager: FavoritesManager!
    var coreDataStack: CoreDataTestStack!
    let testUUID = "1234"
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataTestStack()
        favoritesManager = FavoritesManager(mainContext: coreDataStack.mainContext)
    }

    override func tearDownWithError() throws {
        favoritesManager = nil
        coreDataStack = nil
    }
    
    func test_FavoritesShouldBeEmpty() throws {
        let favoritesList = favoritesManager.getAllFavorites()
        XCTAssertTrue(favoritesList.isEmpty)
    }
    
    func test_saveFavorite() throws {
        favoritesManager.saveFavorite(restaurantUUID: testUUID)
        let favorite = favoritesManager.fetchFavorite(withUUID: testUUID)!
        
        XCTAssertEqual(testUUID, favorite.restaurantUUID)
    }
    
    func test_deleteFavorite() {
        favoritesManager.saveFavorite(restaurantUUID: testUUID)
        var favoritesList = favoritesManager.getAllFavorites()
        
        XCTAssertEqual(favoritesList.count, 1)
        
        favoritesManager.removeFavorite(restaurantUUID: testUUID)
        
        favoritesList = favoritesManager.getAllFavorites()
        XCTAssertEqual(favoritesList.count, 0)
    }
    
    func test_isFavorite() {
        favoritesManager.saveFavorite(restaurantUUID: testUUID)
        let isFavorite = favoritesManager.isFavorite(restaurantUUID: testUUID)
        
        XCTAssertTrue(isFavorite)
    }
    

}
