//
//  CatFactProvider.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

public protocol CatFactProvider {
    func randomFact(completion: @escaping((Result<RandomFact, APIError>) -> Void))
}
