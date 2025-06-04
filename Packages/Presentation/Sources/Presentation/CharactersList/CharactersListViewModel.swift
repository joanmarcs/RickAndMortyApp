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
    
    private var currentPage = 1
    private var pages = 1
    private var isLoading = false
    
    @Published public var title: String = ""
    @Published private(set) var characters: [CharacterViewModel] = []
    @Published private(set) var error: String?
    
    public init(useCase: FetchCharactersUseCase, localizationService: LocalizationService) {
        self.useCase = useCase
        self.localizationService = localizationService
        self.title = localizationService.localized("characters_title")
    }
    
    func fetchCharacters() {
        guard isLoading == false && currentPage <= pages else { return }
        isLoading = true
        let usecase = self.useCase
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let newCharacters = try await usecase.execute(page: self.currentPage)
                let charactersToAdd = newCharacters.results.map {
                    CharacterViewModel(id: $0.id, name: $0.name, image: $0.imageURL)
                }
                pages = newCharacters.pages
                if currentPage == 1 {
                    self.characters = charactersToAdd
                } else {
                    self.characters.append(contentsOf: charactersToAdd)
                }
                currentPage += 1
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func hasReachEnd(of character: CharacterViewModel) -> Bool {
        character.id == characters.last?.id
    }
}
