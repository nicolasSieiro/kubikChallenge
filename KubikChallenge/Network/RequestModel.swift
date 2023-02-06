//
//  RequestModel.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

struct RequestModel {
    let endpoint: Endpoints
    var queryItems: [String:String]?
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLBase = .restaurant_URL
    
    func getURL() -> String {
        return baseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }

    enum Endpoints: String {
        case test = "/TFTest/test.json"
    }

    enum URLBase: String {
        case restaurant_URL = "https://alanflament.github.io"
    }
}


