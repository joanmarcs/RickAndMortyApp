//
//  Untitled.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import Domain

final class MockLocalizationService: LocalizationService {
    func localized(_ key: String) -> String {
        return "Localized-\(key)"
    }
    
    func localized(_ key: String, _ args: CVarArg...) -> String {
        return "Localized-\(key)"
    }
}
