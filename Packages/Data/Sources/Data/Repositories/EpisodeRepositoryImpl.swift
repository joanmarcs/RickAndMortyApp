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

    public init(service: EpisodeService) {
        self.service = service
    }

    public func fetchEpisodes(episodeIds: [Int]) async throws -> [Episode] {
        do {
            let data = try await service.fetchEpisodes(episodeIds: episodeIds)

            let decoder = JSONDecoder()

            if episodeIds.count == 1 {
                let dto = try decoder.decode(EpisodeDTO.self, from: data)
                return [
                    Episode(
                        id: dto.id,
                        name: dto.name,
                        airDate: dto.air_date,
                        code: dto.episode
                    )
                ]
            } else {
                let dtos = try decoder.decode([EpisodeDTO].self, from: data)
                return dtos.map {
                    Episode(
                        id: $0.id,
                        name: $0.name,
                        airDate: $0.air_date,
                        code: $0.episode
                    )
                }
            }
        } catch let error as NetworkError {
            throw NetworkErrorMapper.map(error)
        } catch {
            throw error
        }
    }
}


