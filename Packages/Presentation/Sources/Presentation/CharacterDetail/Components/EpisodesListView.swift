//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//
import Foundation
import SwiftUI
import Domain

public struct EpisodesListView: View {
    let episodes: [String]
    let localizationService: LocalizationService
    
    public var body: some View {
        NavigationView {
            List(episodes, id: \.self) { episodeURL in
                Text(episodeName(from: episodeURL))
            }
            .navigationTitle(localizationService.localized("episodes"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func episodeName(from url: String) -> String {
        guard let lastComponent = url.split(separator: "/").last else { return url }
        return "Episode \(lastComponent)"
    }
}

