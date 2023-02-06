//
//  HomePresenter.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [Item])
    func showError(_ error: String)
}

class HomePresenter {
    var provider: HomeProviderProtocol
    weak var delegate: HomeViewProtocol?
    var restaurantList: [Item] = []
    
    init(provider: HomeProviderProtocol = HomeProvider(), delegate: HomeViewProtocol) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func getRestaurants() async {
        do {
            let restaurants = try await provider.getRestaurants()
            restaurantList = restaurants.data
            delegate?.getData(list: restaurantList)
        } catch {
            delegate?.showError(error.localizedDescription)
        }
    }
}
