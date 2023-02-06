//
//  HomeProvider.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

protocol HomeProviderProtocol {
    func getRestaurants() async throws -> RestaurantModel
}

class HomeProvider: HomeProviderProtocol {
    func getRestaurants() async throws -> RestaurantModel {
        
        let requestModel = RequestModel(endpoint: .test)
        
        do {
            let model = try await Service.callService(requestModel, RestaurantModel.self)
            return model
        } catch {
            print(error)
            throw error
        }
    }
}
