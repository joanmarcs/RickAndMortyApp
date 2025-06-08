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
    func makeCharacterDetail(for character: Character) -> AnyView {
        AnyView(EmptyView())
    }
    
    func makeEpisodesList(for episodeURLs: [String]) -> AnyView {
        AnyView(EmptyView())
    }
}
