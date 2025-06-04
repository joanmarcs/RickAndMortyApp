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

    public func fetchCharacters(page: Int) async throws -> Data {
        let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(page)")!
        return try await client.get(from: url)
    }
}
