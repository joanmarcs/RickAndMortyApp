//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Domain

final class MockFetchCharactersUseCase: FetchCharactersUseCase, @unchecked Sendable {
    var executeCalled = false
    var receivedPage: Int?
    var receivedName: String?
    var receivedStatus: String?
    var receivedGender: String?
    var resultToReturn: CharacterList?
    var errorToThrow: Error?
    
    func execute(page: Int, name: String?, status: String?, gender: String?) async throws -> CharacterList {
        executeCalled = true
        receivedPage = page
        receivedName = name
        receivedStatus = status
        receivedGender = gender
        
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        
        return resultToReturn!
    }
}
