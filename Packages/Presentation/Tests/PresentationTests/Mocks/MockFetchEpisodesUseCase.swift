//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Domain

final class MockFetchEpisodesUseCase: FetchEpisodesUseCase {
    var resultToReturn: [Episode] = []
    var errorToThrow: Error?
    
    func execute(episodeIds: [Int]) async throws -> [Episode] {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        return resultToReturn
    }
}
