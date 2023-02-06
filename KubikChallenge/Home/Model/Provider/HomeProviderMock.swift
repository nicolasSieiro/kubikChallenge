//
//  HomeProviderMock.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

class HomeProviderMock : HomeProviderProtocol {
    
    var throwError = false
    
    func getRestaurants() async throws -> RestaurantModel {
        if throwError {
            throw NetworkError.generic
        }
        
        guard let model = Utils.parseJson(jsonName: "RestaurantList", model: RestaurantModel.self) else {
            throw NetworkError.jsonDecoder
        }
        
        return model
    }
 
}
