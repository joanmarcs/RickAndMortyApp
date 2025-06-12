//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public struct Character: Identifiable, Equatable, Sendable, Hashable {
    public let id: Int
    public let name: String
    public let imageURL: String
    public let status: String
    public let species: String
    public let gender: String
    public let locationName: String
    public let episodes: [String]

    public init(id: Int, name: String, imageURL: String, status: String, species: String, gender: String, locationName: String, episodes: [String]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.status = status
        self.species = species
        self.gender = gender
        self.locationName = locationName
        self.episodes = episodes
    }
}
