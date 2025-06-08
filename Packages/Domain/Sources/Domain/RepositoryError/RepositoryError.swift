//
//  RepositoryError.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import Foundation

public enum RepositoryError: Error, Equatable {
    case custom(String)

    public func localized(using localizationService: LocalizationService) -> String {
        switch self {
        case .custom(let key):
            return localizationService.localized(key)
        }
    }
}

