//
//  CatFactApi.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import Foundation

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
    public func randomFact(completion: @escaping((Result<RandomFact, APIError>) -> Void)) {
        request(endpoint: .random, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: Endpoint, method: Method,
                                     completion: @escaping((Result<T, APIError>) -> Void)) {
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest,
                                  completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
