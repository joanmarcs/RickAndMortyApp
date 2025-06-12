//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import SwiftUI
import Presentation

@main
struct RickAndMortyApp: App {
    
    @StateObject private var coordinator = AppCoordinator()
    
    init() {
        URLCache.shared = URLCache(
            memoryCapacity: 20 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024,
            diskPath: "url_cache"
        )
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}

