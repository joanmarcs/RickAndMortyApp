//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public struct CharacterResponseDTO: Decodable {
    public let results: [CharacterDTO]
}
