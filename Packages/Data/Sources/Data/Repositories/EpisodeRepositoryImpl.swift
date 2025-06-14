//
//  EpisodeRepositoryImpl.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Domain
import Networking

public final class EpisodeRepositoryImpl: EpisodeRepository {
    private let service: EpisodeService
    private let cache: EpisodesCacheActor
    
    public init(service: EpisodeService, cache: EpisodesCacheActor) {
        self.service = service
        self.cache = cache
    }
    
    public func fetchEpisodes(episodeIds: [Int]) async throws -> [Episode] {
        
        guard !episodeIds.isEmpty else { return [] }
        
        if let cached = await cache.getEpisodes(ids: episodeIds) {
            return cached
        }
        
        do {
            let data = try await service.fetchEpisodes(episodeIds: episodeIds)
            let decoder = JSONDecoder()
            
            let episodes: [Episode]
            if episodeIds.count == 1 {
                let dto = try decoder.decode(EpisodeDTO.self, from: data)
                episodes = [dto.toDomain()]
            } else {
                let dtos = try decoder.decode([EpisodeDTO].self, from: data)
                episodes = dtos.map { $0.toDomain() }
            }
            
            await cache.saveEpisodes(episodes)
            return episodes
        } catch let error as NetworkError {
            throw NetworkErrorMapper.map(error)
        } catch {
            throw error
        }
    }
}


