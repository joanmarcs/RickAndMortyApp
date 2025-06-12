//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 12/6/25.
//

import Foundation
import Domain

public actor EpisodesCacheActor {
    private var cache: [Int: Episode] = [:]
    
    public init() {}
    
    public func getEpisodes(ids: [Int]) -> [Episode]? {
        let found = ids.compactMap { cache[$0] }
        return found.count == ids.count ? found : nil
    }
    
    public func saveEpisodes(_ episodes: [Episode]) {
        for episode in episodes {
            cache[episode.id] = episode
        }
    }
    
    public func clear() {
        cache.removeAll()
    }
}
