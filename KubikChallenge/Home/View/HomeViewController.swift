//
//  HomeViewController.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }

}

extension HomeViewController: HomeViewProtocol {
    func getData(list: [Item]) {
        
    }
    
    func showError(_ error: String) {
        
    }
    
    
}
