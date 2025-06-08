//
//  InitTests.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import XCTest
@testable import Data
import Networking
import Domain

final class NetworkErrorMapperTests: XCTestCase {
    
    func test_map_invalidURL_returnsExpectedError() {
        let error = NetworkError.invalidURL
        let mapped = NetworkErrorMapper.map(error)
        XCTAssertEqual(mapped, RepositoryError.custom("error_invalid_url"))
    }
    
    func test_map_invalidResponse_returnsExpectedError() {
        let error = NetworkError.invalidResponse
        let mapped = NetworkErrorMapper.map(error)
        XCTAssertEqual(mapped, RepositoryError.custom("error_invalid_response"))
    }
    
    func test_map_statusCode404_returnsNoResultsError() {
        let error = NetworkError.statusCode(404)
        let mapped = NetworkErrorMapper.map(error)
        XCTAssertEqual(mapped, RepositoryError.custom("error_no_results"))
    }
    
    func test_map_statusCode500_returnsServerGenericError() {
        let error = NetworkError.statusCode(500)
        let mapped = NetworkErrorMapper.map(error)
        XCTAssertEqual(mapped, RepositoryError.custom("error_server_generic"))
    }
    
    func test_map_underlyingError_returnsNetworkGenericError() {
        let error = NetworkError.underlying(NSError(domain: "", code: -1, userInfo: nil))
        let mapped = NetworkErrorMapper.map(error)
        XCTAssertEqual(mapped, RepositoryError.custom("error_network_generic"))
    }
}
