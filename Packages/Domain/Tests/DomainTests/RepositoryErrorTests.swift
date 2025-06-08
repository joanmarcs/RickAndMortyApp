//
//  InitTests.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import XCTest
@testable import Domain

final class RepositoryErrorTests: XCTestCase {
    
    func test_localized_returnsLocalizedString() {
        let error = RepositoryError.custom("some_key")
        let mockLocalizationService = MockLocalizationService()
        
        let result = error.localized(using: mockLocalizationService)
        
        XCTAssertEqual(result, "Localized-some_key")
        XCTAssertEqual(mockLocalizationService.localizedCalledWith, "some_key")
    }
}
