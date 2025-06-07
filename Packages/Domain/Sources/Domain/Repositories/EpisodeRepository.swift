//
//  EpisodeRepository.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation

public protocol EpisodeRepository {
    func fetchEpisodes(episodeIds: [Int]) async throws -> [Episode]
}

