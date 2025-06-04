//
//  CharactersListViewModel.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain

@MainActor
public final class CharacterListViewModel: ObservableObject {
    private let useCase: FetchCharactersUseCase
    private let localizationService: LocalizationService
    
    @Published public var title: String = ""
    @Published public private(set) var characters: [Character] = []
    @Published public private(set) var isLoading = false
    @Published public private(set) var error: String?

    public init(useCase: FetchCharactersUseCase, localizationService: LocalizationService) {
        self.useCase = useCase
        self.localizationService = localizationService
        self.title = localizationService.localized("characters_title")
        
        print(Bundle.module.bundleURL)
        print(localizationService.localized("characters_title"))
        print("Current locale: \(Locale.current.identifier)")

    }

    public func loadCharacters() async {
        isLoading = true
        let useCase = self.useCase
        Task { [weak self] in
            guard let self = self else { return }
            do {
                characters = try await useCase.execute()
            } catch {
                self.error = error.localizedDescription
            }
        }
        isLoading = false
    }
}
