//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import Foundation

public protocol NetworkConfig {
    var baseURL: URL { get }
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

