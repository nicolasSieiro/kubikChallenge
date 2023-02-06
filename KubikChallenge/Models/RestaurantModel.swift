//
//  RestaurantModel.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

struct RestaurantModel: Codable {
    let data: [Item]
}

struct Item: Codable {
    let name, uuid, servesCuisine: String
    let priceRange: Int
    let currenciesAccepted: String
    let address: Address
    let aggregateRatings: AggregateRatings
    let mainPhoto: MainPhoto
    let bestOffer: BestOffer
}

struct Address: Codable {
    let street, postalCode, locality, country: String
}

struct AggregateRatings: Codable {
    let thefork, tripadvisor: Thefork
}

struct Thefork: Codable {
    let ratingValue: Double
    let reviewCount: Int
}

struct BestOffer: Codable {
    let name, label: String
}

struct MainPhoto: Codable {
    let source, the612X344, the480X270, the240X135: String
    let the664X374, the1350X759, the160X120, the80X60: String
    let the92X92, the184X184: String

    enum CodingKeys: String, CodingKey {
        case source
        case the612X344 = "612x344"
        case the480X270 = "480x270"
        case the240X135 = "240x135"
        case the664X374 = "664x374"
        case the1350X759 = "1350x759"
        case the160X120 = "160x120"
        case the80X60 = "80x60"
        case the92X92 = "92x92"
        case the184X184 = "184x184"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(String.self, forKey: .source)
        self.the612X344 = try container.decode(String.self, forKey: .the612X344)
        self.the480X270 = try container.decode(String.self, forKey: .the480X270)
        self.the240X135 = try container.decode(String.self, forKey: .the240X135)
        self.the664X374 = try container.decode(String.self, forKey: .the664X374)
        self.the1350X759 = try container.decode(String.self, forKey: .the1350X759)
        self.the160X120 = try container.decode(String.self, forKey: .the160X120)
        self.the80X60 = try container.decode(String.self, forKey: .the80X60)
        self.the92X92 = try container.decode(String.self, forKey: .the92X92)
        self.the184X184 = try container.decode(String.self, forKey: .the184X184)
    }
}
