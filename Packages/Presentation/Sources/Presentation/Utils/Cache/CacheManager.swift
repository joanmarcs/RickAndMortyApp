//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation

public enum CacheManager {
    public static func clearCharacterCache() async {
        URLCache.shared.removeAllCachedResponses()
        await ImageCache.clear()
    }
}

