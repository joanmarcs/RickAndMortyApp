//
//  Untitled.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Networking

final class MockCharacterService: CharacterService {
    var fetchCharactersCalled = false
    var fetchCharactersParams: (page: Int, name: String?, status: String?, gender: String?)?
    var resultToReturn: Data?
    var errorToThrow: Error?
    
    func fetchCharacters(page: Int, name: String?, status: String?, gender: String?) async throws -> Data {
        fetchCharactersCalled = true
        fetchCharactersParams = (page, name, status, gender)
        
        if let error = errorToThrow {
            throw error
        }
        
        return resultToReturn!
    }
}
