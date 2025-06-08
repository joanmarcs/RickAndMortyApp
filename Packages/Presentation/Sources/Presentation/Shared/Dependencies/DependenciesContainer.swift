//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Foundation
import Domain
import Data
import Networking

public final class DependenciesContainer {
    public let client: HTTPClient
    public let localizationService: LocalizationService
    
    public init() {
        let config = DefaultNetworkConfig()
        self.client = URLSessionHTTPClient(config: config)
        self.localizationService = DefaultLocalizationService()
    }
    
    public func makeCharacterUseCase() -> FetchCharactersUseCase {
        let characterService = CharacterServiceImpl(client: client)
        let characterRepository = CharacterRepositoryImpl(service: characterService)
        return FetchCharactersUseCaseImpl(repository: characterRepository)
    }
    
    public func makeFetchEpisodesUseCase() -> FetchEpisodesUseCase {
        let episodeService = EpisodeServiceImpl(client: client)
        let episodeRepository = EpisodeRepositoryImpl(service: episodeService)
        return FetchEpisodesUseCaseImpl(repository: episodeRepository)
    }
}
