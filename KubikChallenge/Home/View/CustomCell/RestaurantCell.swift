//
//  RestaurantCell.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(restaurant: Item) {
        
    }
}
