//
//  DefaultNetworkingConfig.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import Foundation

public struct DefaultNetworkConfig: NetworkConfig {
    public init() {}

    public var baseURL: URL {
        URL(string: "https://rickandmortyapi.com/api")!
    }

    public var timeout: TimeInterval {
        60
    }

    public var cachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }
}

