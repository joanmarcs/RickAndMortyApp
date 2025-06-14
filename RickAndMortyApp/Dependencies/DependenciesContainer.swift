//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Domain
import Data
import Networking
import Presentation

public final class DependenciesContainer {
    public let client: HTTPClient
    public let localizationService: LocalizationService
    
    public let characterService: CharacterService
    public let episodeService: EpisodeService
    
    public let characterRepository: CharacterRepository
    public let episodeRepository: EpisodeRepository
    
    public let episodesCache: EpisodesCacheActor
    
    public init(
        client: HTTPClient = URLSessionHTTPClient(config: DefaultNetworkConfig()),
        localizationService: LocalizationService = DefaultLocalizationService()
    ) {
        self.client = client
        self.localizationService = localizationService
        
        self.characterService = CharacterServiceImpl(client: client)
        self.episodeService = EpisodeServiceImpl(client: client)
        
        self.episodesCache = EpisodesCacheActor()
        
        self.characterRepository = CharacterRepositoryImpl(service: characterService)
        self.episodeRepository = EpisodeRepositoryImpl(service: episodeService, cache: episodesCache)
    }
    
    public func makeCharacterUseCase() -> FetchCharactersUseCase {
        FetchCharactersUseCaseImpl(repository: characterRepository)
    }
    
    public func makeFetchEpisodesUseCase() -> FetchEpisodesUseCase {
        FetchEpisodesUseCaseImpl(repository: episodeRepository)
    }
}
