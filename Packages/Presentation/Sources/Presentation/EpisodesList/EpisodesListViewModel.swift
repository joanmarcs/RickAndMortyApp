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

    @Published public var episodes: [Episode] = []
    @Published private(set) var error: String?
    @Published public private(set) var isLoading: Bool = false {
        didSet {
            print("isLoading = \(isLoading)")
        }
    }

    public init(episodeUrls: [String], localizationService: LocalizationService, fetchEpisodesUseCase: FetchEpisodesUseCase) {
        self.episodeIds = EpisodeURLParser.episodeIds(from: episodeUrls)
        self.localizationService = localizationService
        self.fetchEpisodesUseCase = fetchEpisodesUseCase
    }

    public func fetchEpisodes()  {
        guard !episodeIds.isEmpty else { return }
        isLoading = true
        
        let useCase = self.fetchEpisodesUseCase
            Task {
                do {
                    let episodes = try await useCase.execute(episodeIds: episodeIds)
                    self.episodes = episodes
                    isLoading = false
                } catch {
                    isLoading = false
                    if let repositoryError = error as? RepositoryError {
                        self.error = repositoryError.localized(using: localizationService)
                    } else {
                        self.error = localizationService.localized("error_unknown")
                    }
                }
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
