//
//  Endpoint.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let queryItems: [URLQueryItem]?

    public init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.queryItems = queryItems
    }
}

