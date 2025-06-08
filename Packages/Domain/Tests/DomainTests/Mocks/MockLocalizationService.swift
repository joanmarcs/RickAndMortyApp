//
//  Untitled.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Foundation
import Domain

final class MockLocalizationService: LocalizationService {
    var localizedCalledWith: String?
    
    func localized(_ key: String) -> String {
        localizedCalledWith = key
        return "Localized-\(key)"
    }
    
    func localized(_ key: String, _ args: CVarArg...) -> String {
        localizedCalledWith = key
        return "Localized-\(key)"
    }
}

