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
    
    public func fetchCharacters(page: Int, name: String?, status: String?, gender: String?) async throws -> CharacterList {
        do {
            let data = try await service.fetchCharacters(page: page, name: name, status: status, gender: gender)
            let decoded = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
            let items = decoded.results.map {
                Character(
                    id: $0.id,
                    name: $0.name,
                    imageURL: $0.image,
                    status: $0.status,
                    species: $0.species,
                    gender: $0.gender,
                    locationName: $0.location.name,
                    episodes: $0.episode
                )
            }
            return CharacterList(results: items, pages: decoded.info.pages)
        } catch let error as NetworkError {
            switch error {
            case .statusCode(let code) where code == 404:
                return CharacterList(results: [], pages: 1)
            default:
                throw NetworkErrorMapper.map(error)
            }
        } catch {
            throw error
        }
    }
}


