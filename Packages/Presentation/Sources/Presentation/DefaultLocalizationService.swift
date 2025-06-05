//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import Domain

public final class DefaultLocalizationService: LocalizationService {
    private let bundle: Bundle

    public init() {
        if let preferredLanguage = Locale.preferredLanguages.first,
           let path = Bundle.module.path(forResource: preferredLanguage.prefix(2).description, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
        } else {
            self.bundle = Bundle.module
        }
    }

    public func localized(_ key: String) -> String {
        NSLocalizedString(key, bundle: bundle, comment: "")
    }
}


