//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import Foundation
import Domain
import SwiftUI
import Data
import Networking

@MainActor
public final class CharacterListCoordinator: CharacterListCoordinatorProtocol {
    private let localizationService: LocalizationService
    private let client: HTTPClient

    public init(localizationService: LocalizationService, client: HTTPClient) {
        self.localizationService = localizationService
        self.client = client
    }

    public func makeCharacterDetail(for character: Character) -> AnyView {
        let episodeService = EpisodeServiceImpl(client: client)
        let episodeRepository = EpisodeRepositoryImpl(service: episodeService)
        let fetchEpisodesUseCase = FetchEpisodesUseCaseImpl(repository: episodeRepository)

        let viewModel = CharacterDetailViewModel(
            character: character,
            localizationService: localizationService,
            coordinator: self
        )

        return AnyView(CharacterDetailView(viewModel: viewModel))
    }
    
    public func makeEpisodesList(for episodeURLs: [String]) -> AnyView {
        let episodeService = EpisodeServiceImpl(client: client)
        let episodeRepository = EpisodeRepositoryImpl(service: episodeService)
        let fetchEpisodesUseCase = FetchEpisodesUseCaseImpl(repository: episodeRepository)

        let viewModel = EpisodesListViewModel(
            episodeUrls: episodeURLs,
            localizationService: localizationService,
            fetchEpisodesUseCase: fetchEpisodesUseCase
        )
        
        return AnyView(EpisodesListView(viewModel: viewModel))
    }

}

