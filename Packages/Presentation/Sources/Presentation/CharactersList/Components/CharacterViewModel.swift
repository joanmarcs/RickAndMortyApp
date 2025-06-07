//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import SwiftUI
import Domain

@MainActor
final class CharacterViewModel: ObservableObject {
    let id: Int
    let name: String
    let imageURL: String
    let status: String
    let species: String
    let gender: String
    let locationName: String
    let episodes: [String]
    
    public init(id: Int, name: String, image: String, status: String, species: String, gender: String, locationName: String, episodes: [String]) {
        self.id = id
        self.name = name
        self.imageURL = image
        self.status = status
        self.species = species
        self.gender = gender
        self.locationName = locationName
        self.episodes = episodes
    }
}

extension CharacterViewModel {
    public func asDomain() -> Character {
        Character (
            id: self.id,
            name: self.name,
            imageURL: self.imageURL,
            status: self.status,
            species: self.species,
            gender: self.gender,
            locationName: self.locationName,
            episodes: self.episodes
        )
    }
}
