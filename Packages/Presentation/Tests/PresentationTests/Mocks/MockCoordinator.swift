//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import SwiftUI
import Domain
import Presentation

final class MockCharacterListCoordinator: CharacterListCoordinatorProtocol {
    var didNavigateToCharacterDetail: Character?
    var didNavigateToEpisodes: [String]?
    
    func navigateToCharacterDetail(_ character: Character) {
        didNavigateToCharacterDetail = character
    }
    
    func navigateToEpisodes(_ episodeURLs: [String]) {
        didNavigateToEpisodes = episodeURLs
    }
}
