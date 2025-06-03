//
//  LocalizationService.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public protocol LocalizationService {
    func localized(_ key: String) -> String
}
