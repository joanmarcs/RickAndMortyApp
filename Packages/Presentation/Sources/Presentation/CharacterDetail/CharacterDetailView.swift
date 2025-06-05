//
//  CharacterDetailView.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import SwiftUI

public struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel

    public init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Imagen principal
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
                }

                // Información del personaje
                VStack(spacing: 16) {
                    Text(viewModel.character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 16) {
                        characterInfo(title: viewModel.localizationService.localized("status"), value: viewModel.character.status)
                        characterInfo(title: viewModel.localizationService.localized("species"), value: viewModel.character.species)
                        characterInfo(title: viewModel.localizationService.localized("gender"), value: viewModel.character.gender)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 4)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)
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
}
