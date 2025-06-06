//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import Foundation
import Domain
import SwiftUI

@MainActor
public final class CharacterListCoordinator: CharacterListCoordinatorProtocol {
    private let localizationService: LocalizationService

    public init(localizationService: LocalizationService) {
        self.localizationService = localizationService
    }

    public func makeCharacterDetail(for character: Character) -> AnyView {
        let viewModel = CharacterDetailViewModel(
            character: character,
            localizationService: localizationService
        )
        return AnyView(CharacterDetailView(viewModel: viewModel))
    }
}

