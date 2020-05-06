//
//  CatFactProvider.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import Foundation
import Combine

public enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

public protocol CatFactProvider {
    func randomFact() -> AnyPublisher<RandomFact, APIError>
}
