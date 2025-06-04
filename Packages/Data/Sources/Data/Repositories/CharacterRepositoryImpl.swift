//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain
import Networking

public final class CharacterRepositoryImpl: CharacterRepository {
    private let service: CharacterService

    public init(service: CharacterService) {
        self.service = service
    }

    public func fetchCharacters() async throws -> [Character] {
        let data = try await service.fetchCharacters()
        let decoded = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
        return decoded.results.map {
            Character(id: $0.id, name: $0.name, imageURL: $0.image)
        }
    }
}


