//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Domain

public struct EpisodeDTO: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let air_date: String
    public let episode: String
    
    public func toDomain() -> Episode {
        return Episode(id: id, name: name, airDate: air_date, code: episode)
    }
}
