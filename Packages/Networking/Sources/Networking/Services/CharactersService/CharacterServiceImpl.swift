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

    public func fetchCharacters(page: Int, name: String?, status: String?, gender: String?) async throws -> Data {
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        if let name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        if let status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        
        if let gender, !gender.isEmpty {
            queryItems.append(URLQueryItem(name: "gender", value: gender))
        }

        let endpoint = Endpoint(path: "character", queryItems: queryItems)

        return try await client.request(endpoint: endpoint, method: .get, body: nil)
    }
}


