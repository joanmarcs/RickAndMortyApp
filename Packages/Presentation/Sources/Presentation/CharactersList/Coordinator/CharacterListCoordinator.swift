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
    private let dependencies: DependenciesContainer

    public init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }

    public func makeCharacterDetail(for character: Character) -> AnyView {
        let viewModel = CharacterDetailViewModel(
            character: character,
            localizationService: dependencies.localizationService,
            coordinator: self
        )

        return AnyView(CharacterDetailView(viewModel: viewModel))
    }
    
    public func makeEpisodesList(for episodeURLs: [String]) -> AnyView {
        let fetchEpisodesUseCase = dependencies.makeFetchEpisodesUseCase()
        
        let viewModel = EpisodesListViewModel(
            episodeUrls: episodeURLs,
            localizationService: dependencies.localizationService,
            fetchEpisodesUseCase: fetchEpisodesUseCase
        )
        
        return AnyView(EpisodesListView(viewModel: viewModel))
    }
}


