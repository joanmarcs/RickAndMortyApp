//
//  Untitled.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Domain

final class MockEpisodeRepository: EpisodeRepository {
    var fetchEpisodesCalled = false
    var receivedEpisodeIds: [Int] = []
    var resultToReturn: [Episode] = []
    
    func fetchEpisodes(episodeIds: [Int]) async throws -> [Episode] {
        fetchEpisodesCalled = true
        receivedEpisodeIds = episodeIds
        return resultToReturn
    }
}
