//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation

public struct EpisodeDTO: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let air_date: String
    public let episode: String
}
