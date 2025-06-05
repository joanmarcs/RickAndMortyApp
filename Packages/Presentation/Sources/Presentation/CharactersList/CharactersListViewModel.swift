//
//  CharactersListViewModel.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain
import Combine

@MainActor
public final class CharacterListViewModel: ObservableObject {
    private let useCase: FetchCharactersUseCase
    public let localizationService: LocalizationService
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var pages = 1
    
    @Published public var title: String = ""
    @Published private(set) var characters: [CharacterViewModel] = []
    @Published private(set) var error: String?
    @Published public var isRefreshing: Bool = false
    @Published public var isLoading: Bool = false
    @Published public var searchText: String = ""
    
    public init(useCase: FetchCharactersUseCase, localizationService: LocalizationService) {
        self.useCase = useCase
        self.localizationService = localizationService
        self.title = localizationService.localized("characters_title")
        
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task { self?.searchCharacters() }
            }
            .store(in: &cancellables)
    }
    
    func refreshCharacters() async {
        isRefreshing = true
        await CacheManager.clearCharacterCache()

        currentPage = 1
        characters = []
        fetchCharacters()
        
        try? await Task.sleep(nanoseconds: 600_000_000)
        isRefreshing = false
    }
    
    func fetchCharacters() {
        guard isLoading == false && currentPage <= pages else { return }
        isLoading = true
        let usecase = self.useCase
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let newCharacters = try await usecase.execute(page: self.currentPage, name: self.searchText)
                let charactersToAdd = newCharacters.results.map {
                    CharacterViewModel(id: $0.id, name: $0.name, image: $0.imageURL, status: $0.status, species: $0.species, gender: $0.gender)
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
    
    func searchCharacters() {
        currentPage = 1
        characters = []
        fetchCharacters()
    }
    
    func hasReachEnd(of character: CharacterViewModel) -> Bool {
        character.id == characters.last?.id
    }
}
