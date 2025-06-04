//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol CharacterRepository {
    func fetchCharacters(page: Int) async throws -> CharacterList
}
