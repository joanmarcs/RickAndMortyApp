//
//  CharacterServiceImpl.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public final class CharacterServiceImpl: CharacterService {
    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func fetchCharacters(page: Int, name: String?) async throws -> Data {
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        if let name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }

        let endpoint = Endpoint(path: "character", queryItems: queryItems)

        return try await client.request(endpoint: endpoint, method: .get, body: nil)
    }
}


