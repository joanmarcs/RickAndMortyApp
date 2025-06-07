//
//  FetchEpisodesUseCase.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//
import Foundation

public protocol FetchEpisodesUseCase {
    func execute(episodeIds: [Int]) async throws -> [Episode]
}

public final class FetchEpisodesUseCaseImpl: FetchEpisodesUseCase {
    private let repository: EpisodeRepository

    public init(repository: EpisodeRepository) {
        self.repository = repository
    }

    public func execute(episodeIds: [Int]) async throws -> [Episode] {
        try await repository.fetchEpisodes(episodeIds: episodeIds)
    }
}
