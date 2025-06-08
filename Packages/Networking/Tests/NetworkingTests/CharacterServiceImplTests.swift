//
//  Untitled.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Networking

final class CharacterServiceImplTests: XCTestCase {
    
    func test_fetchCharacters_callsHTTPClientWithCorrectEndpoint() async throws {
        let mockClient = MockHTTPClient()
        mockClient.resultToReturn = Data()
        
        let service = CharacterServiceImpl(client: mockClient)
        
        _ = try await service.fetchCharacters(page: 1, name: "Rick", status: "Alive", gender: "Male")
        
        XCTAssertTrue(mockClient.requestCalled)
        XCTAssertEqual(mockClient.receivedEndpoint?.path, "character")
        
        let queryItems = mockClient.receivedEndpoint?.queryItems ?? []
        let queryDict = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) })
        
        XCTAssertEqual(queryDict["page"], "1")
        XCTAssertEqual(queryDict["name"], "Rick")
        XCTAssertEqual(queryDict["status"], "Alive")
        XCTAssertEqual(queryDict["gender"], "Male")
        XCTAssertEqual(mockClient.receivedMethod, .get)
    }
}
