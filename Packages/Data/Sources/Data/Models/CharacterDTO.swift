//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain

public struct CharacterDTO: Codable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: String
    public let location: LocationDTO
    public let episode: [String]
    
    public func toDomain() -> Character {
        return Character(id: id, name: name, imageURL: image, status: status, species: species, gender: gender, locationName: location.name, episodes: episode)
    }
}
