//
//  DefaultLocationService.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import Domain

public final class DefaultLocalizationService: LocalizationService {
    public init() {}

    public func localized(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}
