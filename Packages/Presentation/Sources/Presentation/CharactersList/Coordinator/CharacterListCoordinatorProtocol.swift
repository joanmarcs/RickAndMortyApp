//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import SwiftUI
import Domain

@MainActor
public protocol CharacterListCoordinatorProtocol {
    func navigateToCharacterDetail(_ character: Character)
    func navigateToEpisodes(_ episodeURLs: [String])
}
