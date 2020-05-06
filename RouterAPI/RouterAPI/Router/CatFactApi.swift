//
//  CatFactApi.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import Foundation
import Combine

public class CatFactApi: CatFactProvider {
    private let baseURL = "https://cat-fact.herokuapp.com"
    
    private enum Endpoint: String {
        case random = "/facts/random"
    }
    
    private enum Method: String {
        case GET
    }
    
    public init() {}
}

extension CatFactApi {
    public func randomFact() -> AnyPublisher<RandomFact, APIError> {
        return call(.random, method: .GET)
    }
    
    private func call<T: Codable>(_ endPoint: Endpoint, method: Method) -> AnyPublisher<T, APIError> {
        let urlRequest = request(for: endPoint, method: method)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { _ in APIError.serverError }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in APIError.parsingError }
            .eraseToAnyPublisher()
    }
    
    private func request(for endpoint: Endpoint, method: Method) -> URLRequest {
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else {
            preconditionFailure("Bad URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return request
    }

}
