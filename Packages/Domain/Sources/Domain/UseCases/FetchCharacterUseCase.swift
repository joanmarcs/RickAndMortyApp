//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol FetchCharactersUseCase {
    func execute() async throws -> [Character]
}

public final class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    private let repository: CharacterRepository

    public init(repository: CharacterRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Character] {
        try await repository.fetchCharacters()
    }
}
