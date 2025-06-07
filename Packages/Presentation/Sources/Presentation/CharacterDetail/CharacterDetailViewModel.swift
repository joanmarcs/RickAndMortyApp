//
//  CharacterDetailViewModel.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain

@MainActor
public final class CharacterDetailViewModel: ObservableObject {
    public let character: Character
    public let localizationService: LocalizationService
    public let coordinator: CharacterListCoordinatorProtocol
    
    public init(character: Character, localizationService: LocalizationService, coordinator: CharacterListCoordinatorProtocol) {
        self.character = character
        self.localizationService = localizationService
        self.coordinator = coordinator
    }
}


