//
//  Service.swift
//  KubikChallenge
//
//  Created by nicolas sieiro on 06/02/2023.
//

import Foundation

class Service {
    static func callService<T: Decodable>(_ requestModel: RequestModel, _ modelType: T.Type) async throws -> T {

        guard let serviceUrl = URL(string: requestModel.getURL()) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = requestModel.httpMethod.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.httpResponseError
            }
            
            if (httpResponse.statusCode > 299) {
                throw NetworkError.statusCodeError
            }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                return decodeData
            } catch {
                print(error)
                throw NetworkError.couldNotDecodeData
            }
            
        } catch {
            throw NetworkError.generic
        }
    }
}
