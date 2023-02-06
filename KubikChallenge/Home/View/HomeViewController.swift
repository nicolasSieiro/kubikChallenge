//
//  HomeViewController.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)
    var tableView = UITableView()
    private var restaurantList: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableViewConfig()
        
        Task {
            await presenter.getRestaurants()
        }
    }
    
    func tableViewConfig() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: "RestaurantCell")
        
        tableView.rowHeight = 100
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

extension HomeViewController: HomeViewProtocol {
    func getData(list: [Item]) {
        restaurantList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.set(restaurant: restaurantList[indexPath.row])
        return cell
    }
   
}
