//
//  EpisodesListViewModel.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Domain

@MainActor
public final class EpisodesListViewModel: ObservableObject {
    private let fetchEpisodesUseCase: FetchEpisodesUseCase
    private let episodeIds: [Int]
    public let localizationService: LocalizationService
    private let cache: EpisodesCacheActor

    @Published public var episodes: [Episode] = []
    @Published private(set) var error: String?
    @Published public private(set) var isLoading: Bool = false

    public init(episodeUrls: [String],
                localizationService: LocalizationService,
                fetchEpisodesUseCase: FetchEpisodesUseCase,
                cache: EpisodesCacheActor) {
        
        self.episodeIds = EpisodeURLParser.episodeIds(from: episodeUrls)
        self.localizationService = localizationService
        self.fetchEpisodesUseCase = fetchEpisodesUseCase
        self.cache = cache
    }

    public func fetchEpisodes()  {
        guard !episodeIds.isEmpty else { return }
        isLoading = true
        
        let useCase = self.fetchEpisodesUseCase
        Task {
            if let cachedEpisodes = await cache.getEpisodes(ids: episodeIds) {
                self.episodes = cachedEpisodes
                isLoading = false
                return
            }
            
            do {
                let episodes = try await useCase.execute(episodeIds: episodeIds)
                await cache.saveEpisodes(episodes)
                self.episodes = episodes
            } catch {
                if let repositoryError = error as? RepositoryError {
                    self.error = repositoryError.localized(using: localizationService)
                } else {
                    self.error = localizationService.localized("error_unknown")
                }
            }
            isLoading = false
        }
    }
    
    func clearError() {
        error = nil
    }
}


public struct EpisodeURLParser {
    public static func episodeIds(from urls: [String]) -> [Int] {
        urls.compactMap { url in
            guard let idString = url.split(separator: "/").last,
                  let id = Int(idString) else { return nil }
            return id
        }
    }
}
