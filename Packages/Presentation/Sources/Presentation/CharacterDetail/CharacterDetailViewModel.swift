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

    public init(character: Character, localizationService: LocalizationService) {
        self.character = character
        self.localizationService = localizationService
    }
}

