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
    var body: some Scene {
        WindowGroup {
            CharacterListFactory.make()
        }
    }
}

