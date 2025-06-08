//
//  MockEpisodeService.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Networking

final class MockEpisodeService: EpisodeService {
    var fetchEpisodesCalled = false
    var fetchEpisodesParams: [Int] = []
    var resultToReturn: Data?
    var errorToThrow: Error?
    
    func fetchEpisodes(episodeIds: [Int]) async throws -> Data {
        fetchEpisodesCalled = true
        fetchEpisodesParams = episodeIds
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn!
    }
}
