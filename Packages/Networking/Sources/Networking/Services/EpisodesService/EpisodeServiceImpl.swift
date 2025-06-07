//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation

public final class EpisodeServiceImpl: EpisodeService {
    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func fetchEpisodes(episodeIds: [Int]) async throws -> Data {
        let idsString = episodeIds.map { String($0) }.joined(separator: ",")
        let endpoint = Endpoint(path: "episode/\(idsString)")
        return try await client.request(endpoint: endpoint, method: .get, body: nil)
    }
}

