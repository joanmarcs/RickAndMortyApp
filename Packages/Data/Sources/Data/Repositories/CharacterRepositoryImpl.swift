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
    
    public func fetchCharacters(page: Int, name: String?) async throws -> CharacterList {
        let data = try await service.fetchCharacters(page: page, name: name)
        let decoded = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
        let items = decoded.results.map {
            Character(
                id: $0.id,
                name: $0.name,
                imageURL: $0.image,
                status: $0.status,
                species: $0.species,
                gender: $0.gender
            )
        }
        return CharacterList(results: items, pages: decoded.info.pages)
    }
    
}


