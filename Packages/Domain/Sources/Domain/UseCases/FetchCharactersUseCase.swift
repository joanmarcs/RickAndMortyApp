//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol FetchCharactersUseCase {
    func execute(page: Int, name: String?) async throws -> CharacterList
}

public final class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    private let repository: CharacterRepository

    public init(repository: CharacterRepository) {
        self.repository = repository
    }

    public func execute(page: Int, name: String?) async throws -> CharacterList {
        try await repository.fetchCharacters(page: page, name: name)
    }
}
