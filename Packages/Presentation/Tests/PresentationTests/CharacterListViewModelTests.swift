//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Presentation
import Domain
import Data

final class CharacterListViewModelTests: XCTestCase {
    
    func test_fetchCharacters_success_updatesCharacters() async throws {
        let mockUseCase = MockFetchCharactersUseCase()
        let mockLocalizationService = MockLocalizationService()
        let mockCoordinator = MockCharacterListCoordinator()
        
        let expectedCharacters = [
            Character(id: 1, name: "Rick", imageURL: "url", status: "Alive", species: "Human", gender: "Male", locationName: "Earth", episodes: [])
        ]
        
        mockUseCase.resultToReturn = CharacterList(results: expectedCharacters, pages: 1)
        
        let viewModel = await CharacterListViewModel(
            useCase: mockUseCase,
            localizationService: mockLocalizationService,
            coordinator: mockCoordinator
        )
        
        await viewModel.fetchCharacters()
        
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        XCTAssertTrue(mockUseCase.executeCalled)
        let charactersCount = await MainActor.run { viewModel.characters.count }
        XCTAssertEqual(charactersCount, 1)
        
        let firstCharacterName = await MainActor.run { viewModel.characters.first?.name }
        XCTAssertEqual(firstCharacterName, "Rick")
        
        let error = await MainActor.run { viewModel.error }
        XCTAssertNil(error)
    }
    
    func test_fetchCharacters_failure_setsError() async throws {
        let mockUseCase = MockFetchCharactersUseCase()
        let mockLocalizationService = MockLocalizationService()
        let mockCoordinator = MockCharacterListCoordinator()
        
        mockUseCase.errorToThrow = RepositoryError.custom("some_error_key")
        
        let viewModel = await CharacterListViewModel(
            useCase: mockUseCase,
            localizationService: mockLocalizationService,
            coordinator: mockCoordinator
        )
        
        await viewModel.fetchCharacters()
        
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3s
        
        XCTAssertTrue(mockUseCase.executeCalled)
        let charactersCount = await MainActor.run { viewModel.characters.count }
        XCTAssertEqual(charactersCount, 0)
        
        let error = await MainActor.run { viewModel.error }
        XCTAssertEqual(error, "Localized-some_error_key")
    }
    
    func test_searchText_updatesCharacters() async throws {
        let mockUseCase = MockFetchCharactersUseCase()
        let mockLocalizationService = MockLocalizationService()
        let mockCoordinator = MockCharacterListCoordinator()
        
        let expectedCharacters = [
            Character(id: 1, name: "Morty", imageURL: "url", status: "Alive", species: "Human", gender: "Male", locationName: "Earth", episodes: [])
        ]
        
        mockUseCase.resultToReturn = CharacterList(results: expectedCharacters, pages: 1)
        
        let viewModel = await CharacterListViewModel(
            useCase: mockUseCase,
            localizationService: mockLocalizationService,
            coordinator: mockCoordinator
        )
        
        await MainActor.run {
            viewModel.searchText = "Morty"
        }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertEqual(mockUseCase.receivedName, "Morty")
        let firstCharacterName = await MainActor.run { viewModel.characters.first?.name }
        XCTAssertEqual(firstCharacterName, "Morty")
    }
}
