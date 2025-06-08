//
//  Composer.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Data
import Domain
import Networking

public enum CharacterListFactory {
    @MainActor
    public static func make(dependencies: DependenciesContainer) -> CharacterListView {
        let useCase = dependencies.makeCharacterUseCase()
        let coordinator = CharacterListCoordinator(
            dependencies: dependencies
        )
        
        let viewModel = CharacterListViewModel(
            useCase: useCase,
            localizationService: dependencies.localizationService,
            coordinator: coordinator
        )
        
        return CharacterListView(viewModel: viewModel)
    }
}
