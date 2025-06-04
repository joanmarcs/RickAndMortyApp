//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    public init() {}

    public func get(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
