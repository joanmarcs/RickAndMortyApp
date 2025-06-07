//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation

public protocol EpisodeService {
    func fetchEpisodes(episodeIds: [Int]) async throws -> Data
}

