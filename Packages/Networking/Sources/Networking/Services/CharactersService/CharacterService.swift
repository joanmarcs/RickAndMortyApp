//
//  CharacterService.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol CharacterService {
    func fetchCharacters(page: Int, name: String?, status: String?, gender: String?) async throws -> Data
}

