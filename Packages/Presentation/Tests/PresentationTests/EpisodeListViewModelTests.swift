//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Presentation
import Domain

final class EpisodesListViewModelTests: XCTestCase {
    
    func test_fetchEpisodes_success_updatesEpisodes() async throws {
        let mockUseCase = MockFetchEpisodesUseCase()
        let mockLocalizationService = MockLocalizationService()
        let cache = EpisodesCacheActor()
        
        mockUseCase.resultToReturn = [
            Episode(id: 1, name: "Pilot", airDate: "2017-01-01", code: "S01E01")
        ]
        
        let viewModel = await EpisodesListViewModel(
            episodeUrls: ["https://rickandmortyapi.com/api/episode/1"],
            localizationService: mockLocalizationService,
            fetchEpisodesUseCase: mockUseCase,
            cache: cache
        )
        
        await viewModel.fetchEpisodes()
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        let episodesCount = await MainActor.run { viewModel.episodes.count }
        XCTAssertEqual(episodesCount, 1)
        
        let firstEpisodeName = await MainActor.run { viewModel.episodes.first?.name }
        XCTAssertEqual(firstEpisodeName, "Pilot")
        
        let isLoading = await MainActor.run { viewModel.isLoading }
        XCTAssertFalse(isLoading)
        
        let error = await MainActor.run { viewModel.error }
        XCTAssertNil(error)
    }
    
    func test_fetchEpisodes_failure_setsError() async throws {
        let mockUseCase = MockFetchEpisodesUseCase()
        let mockLocalizationService = MockLocalizationService()
        let cache = EpisodesCacheActor()
        
        mockUseCase.errorToThrow = RepositoryError.custom("error_network")
        
        let viewModel = await EpisodesListViewModel(
            episodeUrls: ["https://rickandmortyapi.com/api/episode/1"],
            localizationService: mockLocalizationService,
            fetchEpisodesUseCase: mockUseCase,
            cache: cache
        )
        
        await viewModel.fetchEpisodes()
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        let episodesCount = await MainActor.run { viewModel.episodes.count }
        XCTAssertEqual(episodesCount, 0)
        
        let isLoading = await MainActor.run { viewModel.isLoading }
        XCTAssertFalse(isLoading)
        
        let error = await MainActor.run { viewModel.error }
        XCTAssertEqual(error, "Localized-error_network")
    }
    
}
