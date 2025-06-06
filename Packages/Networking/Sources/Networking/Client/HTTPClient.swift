//
//  HTTPClient.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol HTTPClient {
    func request(
        endpoint: Endpoint,
        method: HTTPMethod,
        body: Data?
    ) async throws -> Data
}

