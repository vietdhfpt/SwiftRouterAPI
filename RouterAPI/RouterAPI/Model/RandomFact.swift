//
//  RandomFact.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import Foundation

public struct RandomFact: Codable {
    public var _id: String = ""
    public var __v: Int = 0
    public var user: String = ""
    public var text: String = ""
    public var updatedAt: String = ""
    public var createdAt: String = ""
    public var deleted: Bool = false
    public var source: Source = .user
    public var status: Status = Status()
    public var used: Bool = false
    public var type: String = ""
    
    public enum Source: String, Codable {
        case user
        case api
    }
    
    public struct Status: Codable {
        public var verified: Bool = false
        public var sentCount: Int = 0
    }
}


