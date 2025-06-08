//
//  Untitled.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Networking

final class EpisodeServiceImplTests: XCTestCase {
    
    func test_fetchEpisodes_callsHTTPClientWithCorrectEndpoint() async throws {
        let mockClient = MockHTTPClient()
        mockClient.resultToReturn = Data()
        
        let service = EpisodeServiceImpl(client: mockClient)
        
        _ = try await service.fetchEpisodes(episodeIds: [1, 2, 3])
        
        XCTAssertTrue(mockClient.requestCalled)
        XCTAssertEqual(mockClient.receivedEndpoint?.path, "episode/1,2,3")
        XCTAssertEqual(mockClient.receivedMethod, .get)
    }
}
