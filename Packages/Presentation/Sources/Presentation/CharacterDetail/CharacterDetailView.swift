//
//  CharacterDetailView.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import SwiftUI
import MapKit

public struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    @State private var showShareSheet = false
    @State private var imageLoaded = false
    @State private var showEpisodes = false
    
    public init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                characterImage
                characterInfoSection
                episodesSection
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: [shareText])
        }
    }
    
    private var characterImage: some View {
        Group {
            if let url = URL(string: viewModel.character.imageURL) {
                RemoteImageView(
                    url: url,
                    placeholder: {
                        ZStack {
                            Color.gray.opacity(0.2)
                            ProgressView()
                        }
                    },
                    errorView: {
                        Image(systemName: "xmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                )
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 6)
                .padding(.horizontal)
                .scaleEffect(imageLoaded ? 1 : 0.95)
                .opacity(imageLoaded ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: imageLoaded)
                .onAppear { imageLoaded = true }
            }
        }
    }
    
    private var characterInfoSection: some View {
        VStack(spacing: 16) {
            Text(viewModel.character.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 16) {
                characterInfoWithStatusIcon(title: viewModel.localizationService.localized("status"), value: viewModel.character.status).accessibilityIdentifier(AccessibilityIdentifier.CharacterDetail.screenTitle)
                characterInfo(title: viewModel.localizationService.localized("species"), value: viewModel.character.species)
                characterInfo(title: viewModel.localizationService.localized("gender"), value: viewModel.character.gender)
            }
            characterInfo(title: viewModel.localizationService.localized("location"), value: viewModel.character.locationName)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
    
    private var episodesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(viewModel.localizationService.localized(
                    "appears_in_episodes_format",
                    viewModel.character.episodes.count
                ))
                .font(.headline)
                
                Spacer()
                
                Button {
                    viewModel.coordinator.navigateToEpisodes(viewModel.character.episodes)
                } label: {
                    Text(viewModel.localizationService.localized("see_episodes"))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .accessibilityIdentifier(AccessibilityIdentifier.CharacterDetail.seeEpisodesButton)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }

    
    private func characterInfo(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func characterInfoWithStatusIcon(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 6) {
                Circle()
                    .fill(colorForStatus(value))
                    .frame(width: 10, height: 10)
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func colorForStatus(_ status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
    
    private func episodeName(from url: String) -> String {
        guard let lastComponent = url.split(separator: "/").last else { return url }
        return "Episode \(lastComponent)"
    }
    
    private var shareText: String {
        """
        \(viewModel.character.name)
        \(viewModel.localizationService.localized("status")): \(viewModel.character.status)
        \(viewModel.localizationService.localized("species")): \(viewModel.character.species)
        \(viewModel.localizationService.localized("gender")): \(viewModel.character.gender)
        \(viewModel.localizationService.localized("location")): \(viewModel.character.locationName)
        """
    }

}
