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
    @StateObject private var viewModel: EpisodesListViewModel
    @State private var expandedEpisodeId: Int?
    
    public init(viewModel: EpisodesListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.episodes) { episode in
                        episodeCard(for: episode)
                            .animation(.easeInOut, value: expandedEpisodeId)
                    }
                }
                .padding()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.2).ignoresSafeArea()
                ProgressView()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 6)
            }
        }
        .navigationTitle(viewModel.localizationService.localized("episodes"))
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.fetchEpisodes()
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.error != nil },
            set: { _ in }
        )) {
            Alert(
                title: Text(viewModel.localizationService.localized("error_alert_title")),
                message: Text(viewModel.error ?? ""),
                dismissButton: .default(Text(viewModel.localizationService.localized("general_accept")), action: {
                    viewModel.clearError()
                })
            )
        }
    }
    
    @ViewBuilder
    private func episodeCard(for episode: Episode) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(episode.id). \(episode.name)")
                    .font(.headline).accessibilityIdentifier(AccessibilityIdentifier.EpisodesList.screen)

                Spacer()

                Button(action: {
                    toggleExpansion(for: episode.id)
                }) {
                    Image(systemName: expandedEpisodeId == episode.id ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                }
            }

            if expandedEpisodeId == episode.id {
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.localizationService.localized("episode_code")): \(episode.code)")
                    Text("\(viewModel.localizationService.localized("air_date")): \(episode.airDate)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private func toggleExpansion(for episodeId: Int) {
        if expandedEpisodeId == episodeId {
            expandedEpisodeId = nil
        } else {
            expandedEpisodeId = episodeId
        }
    }
}
