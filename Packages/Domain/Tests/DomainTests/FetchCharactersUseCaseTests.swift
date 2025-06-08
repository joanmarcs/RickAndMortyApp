//
//  Untitled.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Domain

final class FetchCharactersUseCaseTests: XCTestCase {
    
    func test_execute_callsRepository_andReturnsCharacters() async throws {
        let mockRepository = MockCharacterRepository()
        let expectedCharacters = [
            Character(id: 1, name: "Rick", imageURL: "url", status: "Alive", species: "Human", gender: "Male", locationName: "Earth", episodes: [])
        ]
        mockRepository.resultToReturn = CharacterList(results: expectedCharacters, pages: 1)
        
        let useCase = FetchCharactersUseCaseImpl(repository: mockRepository)
        
        let result = try await useCase.execute(page: 1, name: "Rick", status: "Alive", gender: "Male")
        
        XCTAssertTrue(mockRepository.fetchCharactersCalled)
        XCTAssertEqual(mockRepository.receivedPage, 1)
        XCTAssertEqual(mockRepository.receivedName, "Rick")
        XCTAssertEqual(mockRepository.receivedStatus, "Alive")
        XCTAssertEqual(mockRepository.receivedGender, "Male")
        XCTAssertEqual(result.results, expectedCharacters)
        XCTAssertEqual(result.pages, 1)
    }
}
