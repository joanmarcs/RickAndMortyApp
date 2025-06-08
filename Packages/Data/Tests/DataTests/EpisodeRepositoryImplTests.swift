//
//  EpisodeRepositoryImplTests.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Data
import Domain
import Networking

final class EpisodeRepositoryImplTests: XCTestCase {
    
    func test_fetchEpisodes_singleEpisode_returnsMappedEpisode() async throws {
        let mockService = MockEpisodeService()
        let dto = EpisodeDTO(id: 1, name: "Pilot", air_date: "2013-12-02", episode: "S01E01")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        mockService.resultToReturn = try! encoder.encode(dto)
        
        let sut = EpisodeRepositoryImpl(service: mockService)

        let result = try await sut.fetchEpisodes(episodeIds: [1])

        XCTAssertTrue(mockService.fetchEpisodesCalled)
        XCTAssertEqual(mockService.fetchEpisodesParams, [1])
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Pilot")
    }
    
    func test_fetchEpisodes_multipleEpisodes_returnsMappedEpisodes() async throws {
        let mockService = MockEpisodeService()
        let dtos = [
            EpisodeDTO(id: 1, name: "Pilot", air_date: "2013-12-02", episode: "S01E01"),
            EpisodeDTO(id: 2, name: "Lawnmower Dog", air_date: "2013-12-09", episode: "S01E02")
        ]
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        mockService.resultToReturn = try! encoder.encode(dtos)
        
        let sut = EpisodeRepositoryImpl(service: mockService)
        
        let result = try await sut.fetchEpisodes(episodeIds: [1, 2])

        XCTAssertTrue(mockService.fetchEpisodesCalled)
        XCTAssertEqual(mockService.fetchEpisodesParams, [1, 2])
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Pilot")
    }
    
    func test_fetchEpisodes_networkError_throwsMappedError() async {
        let mockService = MockEpisodeService()
        mockService.errorToThrow = NetworkError.invalidResponse
        
        let sut = EpisodeRepositoryImpl(service: mockService)
        
        do {
            _ = try await sut.fetchEpisodes(episodeIds: [1])
            XCTFail("Expected to throw error")
        } catch let error as RepositoryError {
            XCTAssertEqual(error, RepositoryError.custom("error_invalid_response"))
        } catch {
            XCTFail("Unexpected error type")
        }
    }
}
