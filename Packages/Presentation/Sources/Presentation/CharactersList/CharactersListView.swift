//
//  CharactersListView.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import SwiftUI
import Domain

public struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel

    public init(viewModel: CharacterListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    LazyVGrid(columns: [
                        .init(.flexible()),
                        .init(.flexible()),
                        .init(.flexible())
                    ]) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            CharacterView(viewModel: character)
                                .onAppear {
                                    if viewModel.hasReachEnd(of: character) {
                                        viewModel.fetchCharacters()
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .refreshable {
                    await viewModel.refreshCharacters()
                }

                if viewModel.isRefreshing {
                    ZStack {
                        Color.black.opacity(0.2)
                            .ignoresSafeArea()

                        ProgressView()
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                    }
                    .zIndex(1)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 2), value: viewModel.isRefreshing)
                }
            }
            .navigationTitle(viewModel.title)
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}


