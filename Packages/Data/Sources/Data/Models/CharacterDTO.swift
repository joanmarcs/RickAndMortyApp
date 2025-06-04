//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public struct CharacterDTO: Decodable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: String
}
