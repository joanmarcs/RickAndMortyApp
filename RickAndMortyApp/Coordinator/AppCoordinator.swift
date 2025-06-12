//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import SwiftUI
import Domain
import Data
import Networking
import Presentation

@MainActor
public final class AppCoordinator: ObservableObject {
    @Published public var navigationPath = NavigationPath()
    
    public var navigationPathBinding: Binding<NavigationPath> {
        Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )
    }
    
    private let dependencies = DependenciesContainer()
    
    private lazy var characterListViewModel = CharacterListViewModel(
        useCase: dependencies.makeCharacterUseCase(),
        localizationService: dependencies.localizationService,
        coordinator: self
    )
    
    public init() {}
    
    public func start() -> some View {
        NavigationStack(path: navigationPathBinding) {
            CharacterListView(viewModel: characterListViewModel)
            .navigationDestination(for: AppDestination.self) { destination in
                self.destinationView(for: destination)
            }
        }
    }
    
    @ViewBuilder
    private func destinationView(for destination: AppDestination) -> some View {
        switch destination {
        case .characterDetail(let character):
            CharacterDetailView(viewModel: CharacterDetailViewModel(
                character: character,
                localizationService: dependencies.localizationService,
                coordinator: self
            ))
        case .episodes(let episodeUrls):
            EpisodesListView(viewModel: EpisodesListViewModel(
                episodeUrls: episodeUrls,
                localizationService: dependencies.localizationService,
                fetchEpisodesUseCase: dependencies.makeFetchEpisodesUseCase(),
                cache: dependencies.episodesCache
            ))
        }
    }
}

extension AppCoordinator: CharacterListCoordinatorProtocol {
    public func navigateToCharacterDetail(_ character: Character) {
        navigationPath.append(AppDestination.characterDetail(character))
    }
    
    public func navigateToEpisodes(_ episodeURLs: [String]) {
        navigationPath.append(AppDestination.episodes(episodeURLs))
    }
}
