//
//  RestaurantCell.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import UIKit
import Kingfisher

class RestaurantCell: UITableViewCell {
    
    var restTitleLabel = UILabel()
    var restRatingLabel = UILabel()
    var restAddressLabel = UILabel()
    var restImageView = UIImageView()
    var favoriteButton = UIButton()
    var imagePlaceholder = UIImage(systemName: "questionmark.circle")
    private var restaurantUUID = ""
    let manager = FavoritesManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        configureLabels()
        configureFavoriteButton()
    }
    
    func configureImageView() {
        addSubview(restImageView)
        restImageView.layer.cornerRadius = 10
        restImageView.clipsToBounds = true
        
        
        restImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            restImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            restImageView.heightAnchor.constraint(equalToConstant: 92),
            restImageView.widthAnchor.constraint(equalTo: restImageView.heightAnchor)
        ])
    }
    
    func configureLabels() {
        addSubview(restTitleLabel)
        addSubview(restRatingLabel)
        addSubview(restAddressLabel)
        
        //Title
        restTitleLabel.numberOfLines = 1
        restTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            restTitleLabel.leadingAnchor.constraint(equalTo: restImageView.trailingAnchor, constant: 20),
            restTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        //Rating
        restRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restRatingLabel.leadingAnchor.constraint(equalTo: restImageView.trailingAnchor, constant: 20),
            restRatingLabel.bottomAnchor.constraint(equalTo: restTitleLabel.topAnchor, constant: -10)
        ])

        //Address
        restAddressLabel.numberOfLines = 0
        restAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        restAddressLabel.font = restAddressLabel.font.withSize(14)
        NSLayoutConstraint.activate([
            restAddressLabel.topAnchor.constraint(equalTo: restTitleLabel.bottomAnchor, constant: 6),
            restAddressLabel.leadingAnchor.constraint(equalTo: restImageView.trailingAnchor, constant: 20),
            restAddressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            restAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureFavoriteButton() {
        addSubview(favoriteButton)
        
        favoriteButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }
    
    @objc func onTap(sender: UIButton!) {
        
    }
    
    func set(restaurant: Item) {
        //Name
        restTitleLabel.text = restaurant.name
        
        //Image
        if let mainImage = restaurant.mainPhoto?.the92X92, let url = URL(string: mainImage) {
            restImageView.kf.setImage(with: url, placeholder: imagePlaceholder)
        } else {
            restImageView.image = imagePlaceholder
        }
        
        //Rating
        let ratingText = String(format: "%.1f", restaurant.aggregateRatings.thefork.ratingValue)
        restRatingLabel.text = "\(ratingText) / 10"
        
        //Address
        let formatedAddress = "\(restaurant.address.street), \(restaurant.address.country), \(restaurant.address.locality)"
        restAddressLabel.text = formatedAddress
        
        //Favorite
        checkFavorite(with: restaurant.uuid)
        restaurantUUID = restaurant.uuid
    }
    
    func checkFavorite(with uuid: String) {
        let isFavorite = manager.isFavorite(restaurantUUID: restaurantUUID)
        
        if isFavorite == true {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            //remove favorite
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            manager.saveFavorite(restaurantUUID: restaurantUUID)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
