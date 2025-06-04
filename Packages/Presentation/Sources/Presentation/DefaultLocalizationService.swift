//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import Domain

public final class DefaultLocalizationService: LocalizationService {
    public init() {}

    public func localized(_ key: String) -> String {
        guard let path = Bundle.module.path(forResource: Locale.preferredLanguages.first, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, bundle: .module, comment: "")
        }

        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

