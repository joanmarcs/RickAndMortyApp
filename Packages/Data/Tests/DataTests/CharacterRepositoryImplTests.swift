//
//  Untitled.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
import Domain
import Networking
@testable import Data

final class CharacterRepositoryImplTests: XCTestCase {
    
    func test_fetchCharacters_success_returnsMappedCharacters() async throws {
        let mockService = MockCharacterService()
        
        let dto = CharacterResponseDTO(
            results: [
                CharacterDTO(
                    id: 1,
                    name: "Rick",
                    status: "Alive",
                    species: "Human",
                    gender: "Male",
                    image: "url",
                    location: LocationDTO(name: "Earth"),
                    episode: ["https://episode/1"]
                )
            ],
            info: InfoDTO(count: 1, pages: 1, next: nil, prev: nil)
        )
        
        mockService.resultToReturn = try! JSONEncoder().encode(dto)
        
        let sut = CharacterRepositoryImpl(service: mockService)
        
        let result = try await sut.fetchCharacters(page: 1, name: "Rick", status: "Alive", gender: "Male")
        
        XCTAssertTrue(mockService.fetchCharactersCalled)
        XCTAssertEqual(mockService.fetchCharactersParams?.page, 1)
        XCTAssertEqual(mockService.fetchCharactersParams?.name, "Rick")
        XCTAssertEqual(result.results.count, 1)
        XCTAssertEqual(result.pages, 1)
        XCTAssertEqual(result.results.first?.name, "Rick")
    }
    
    func test_fetchCharacters_404_returnsEmptyList() async throws {
        let mockService = MockCharacterService()
        mockService.errorToThrow = NetworkError.statusCode(404)
        
        let sut = CharacterRepositoryImpl(service: mockService)

        let result = try await sut.fetchCharacters(page: 1, name: nil, status: nil, gender: nil)
        
        XCTAssertTrue(mockService.fetchCharactersCalled)
        XCTAssertEqual(result.results.count, 0)
        XCTAssertEqual(result.pages, 1)
    }
    
    func test_fetchCharacters_otherNetworkError_throwsMappedError() async {
        let mockService = MockCharacterService()
        mockService.errorToThrow = NetworkError.invalidURL
        
        let sut = CharacterRepositoryImpl(service: mockService)
        
        do {
            _ = try await sut.fetchCharacters(page: 1, name: nil, status: nil, gender: nil)
            XCTFail("Expected to throw error")
        } catch let error as RepositoryError {
            XCTAssertEqual(error, RepositoryError.custom("error_invalid_url"))
        } catch {
            XCTFail("Unexpected error type")
        }
    }
}
