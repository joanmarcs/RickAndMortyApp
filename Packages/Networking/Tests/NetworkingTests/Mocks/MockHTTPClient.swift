//
//  Untitled.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Networking

final class MockHTTPClient: HTTPClient {
    var requestCalled = false
    var receivedEndpoint: Endpoint?
    var receivedMethod: HTTPMethod?
    var receivedBody: Data?
    var resultToReturn: Data?
    var errorToThrow: Error?
    
    func request(endpoint: Endpoint, method: HTTPMethod, body: Data?) async throws -> Data {
        requestCalled = true
        receivedEndpoint = endpoint
        receivedMethod = method
        receivedBody = body
        
        if let error = errorToThrow {
            throw error
        }
        
        return resultToReturn!
    }
}
