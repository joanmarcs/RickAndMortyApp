//
//  Composer.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Data
import Domain
import Networking
import Presentation

public enum CharacterListFactory {
    @MainActor
    public static func make() -> CharacterListView {
        let config = DefaultNetworkConfig()
        let client = URLSessionHTTPClient(config: config)
        let service = CharacterServiceImpl(client: client)
        let repository = CharacterRepositoryImpl(service: service)
        let useCase = FetchCharactersUseCaseImpl(repository: repository)
        let localizationService = DefaultLocalizationService()
        let coordinator = CharacterListCoordinator(localizationService: localizationService, client: client)

        let viewModel = CharacterListViewModel(
                useCase: useCase,
                localizationService: localizationService,
                coordinator: coordinator
            )
        return CharacterListView(viewModel: viewModel)
    }
}
