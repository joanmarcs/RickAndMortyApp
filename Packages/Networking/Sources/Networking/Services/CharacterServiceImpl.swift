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
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        if let name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        components.queryItems = queryItems
        return try await client.get(from: components.url!)
    }

}
