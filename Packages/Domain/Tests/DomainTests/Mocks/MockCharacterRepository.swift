//
//  Untitled.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Domain

final class MockCharacterRepository: CharacterRepository {
    var fetchCharactersCalled = false
    var receivedPage: Int?
    var receivedName: String?
    var receivedStatus: String?
    var receivedGender: String?
    var resultToReturn: CharacterList!
    
    func fetchCharacters(page: Int, name: String?, status: String?, gender: String?) async throws -> CharacterList {
        fetchCharactersCalled = true
        receivedPage = page
        receivedName = name
        receivedStatus = status
        receivedGender = gender
        return resultToReturn
    }
}
