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
    public let coordinator: CharacterListCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var pages = 1
    
    private var isLoadingUserConfiguration = false
    
    @Published public var title: String = ""
    @Published private(set) var characters: [CharacterViewModel] = []
    @Published private(set) var error: String?
    @Published public var isRefreshing: Bool = false
    @Published public var isLoading: Bool = false
    @Published public var searchText: String = ""
    @Published public var selectedStatus: String? {
        didSet {
            guard !isLoadingUserConfiguration else { return }
            saveUserConfiguration()
        }
    }
    @Published public var selectedGender: String? {
        didSet {
            guard !isLoadingUserConfiguration else { return }
            saveUserConfiguration()
        }
    }
    @Published public var isGrid: Bool = true {
        didSet {
            guard !isLoadingUserConfiguration else { return }
            saveUserConfiguration()
        }
    }
    
    public init(useCase: FetchCharactersUseCase, localizationService: LocalizationService,
                coordinator: CharacterListCoordinatorProtocol) {
        self.useCase = useCase
        self.localizationService = localizationService
        self.coordinator = coordinator
        self.title = localizationService.localized("characters_title")
        
        loadUserConfiguration()
        
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task { self?.searchCharacters() }
            }
            .store(in: &cancellables)
        
        $selectedStatus
            .sink { [weak self] _ in
                Task { self?.searchCharacters() }
            }
            .store(in: &cancellables)

        $selectedGender
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
                let newCharacters = try await usecase.execute(page: self.currentPage, name: self.searchText, status: self.selectedStatus, gender: self.selectedGender)
                let charactersToAdd = newCharacters.results.map {
                    CharacterViewModel(
                        id: $0.id,
                        name: $0.name,
                        image: $0.imageURL,
                        status: $0.status,
                        species: $0.species,
                        gender: $0.gender,
                        locationName: $0.locationName,
                        episodes: $0.episodes
                    )
                }
                pages = newCharacters.pages
                if currentPage == 1 {
                    self.characters = charactersToAdd
                } else {
                    self.characters.append(contentsOf: charactersToAdd)
                }
                currentPage += 1
            } catch {
                if let repositoryError = error as? RepositoryError {
                    self.error = repositoryError.localized(using: localizationService)
                } else {
                    self.error = localizationService.localized("error_unknown")
                }
            }
            isLoading = false
        }
    }
    
    func searchCharacters() {
        currentPage = 1
        characters = []
        fetchCharacters()
    }
    
    func hasReachedEnd(of character: CharacterViewModel) -> Bool {
        character.id == characters.last?.id
    }
    
    func clearError() {
        error = nil
    }
    
    private let statusKey = "selectedStatus"
    private let genderKey = "selectedGender"
    private let isGridKey = "isGrid"
    
    private func saveUserConfiguration() {
        if let status = selectedStatus {
            UserDefaults.standard.set(status, forKey: statusKey)
        } else {
            UserDefaults.standard.removeObject(forKey: statusKey)
        }
        
        if let gender = selectedGender {
            UserDefaults.standard.set(gender, forKey: genderKey)
        } else {
            UserDefaults.standard.removeObject(forKey: genderKey)
        }
        UserDefaults.standard.set(isGrid, forKey: isGridKey)
        UserDefaults.standard.synchronize()
    }

    private func loadUserConfiguration() {
        isLoadingUserConfiguration = true
        selectedStatus = UserDefaults.standard.string(forKey: statusKey)
        selectedGender = UserDefaults.standard.string(forKey: genderKey)
        if UserDefaults.standard.object(forKey: isGridKey) != nil {
            isGrid = UserDefaults.standard.bool(forKey: isGridKey)
        } else {
            isGrid = true
        }
        isLoadingUserConfiguration = false
    }
}
