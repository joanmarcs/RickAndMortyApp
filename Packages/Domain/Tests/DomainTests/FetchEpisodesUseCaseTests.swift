//
//  Untitled.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Domain

final class FetchEpisodesUseCaseTests: XCTestCase {
    
    func test_execute_callsRepository_andReturnsEpisodes() async throws {
        let mockRepository = MockEpisodeRepository()
        let expectedEpisodes = [
            Episode(id: 1, name: "Pilot", airDate: "2013-12-02", code: "S01E01")
        ]
        mockRepository.resultToReturn = expectedEpisodes
        
        let useCase = FetchEpisodesUseCaseImpl(repository: mockRepository)
        
        let result = try await useCase.execute(episodeIds: [1])
        
        XCTAssertTrue(mockRepository.fetchEpisodesCalled)
        XCTAssertEqual(mockRepository.receivedEpisodeIds, [1])
        XCTAssertEqual(result, expectedEpisodes)
    }
}
