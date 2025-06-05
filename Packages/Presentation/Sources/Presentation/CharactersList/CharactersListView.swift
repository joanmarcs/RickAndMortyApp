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
                Color(.systemGray6).ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView(viewModel.localizationService.localized("loading"))
                            .padding()
                        Spacer()
                    }
                } else if !viewModel.isLoading && viewModel.characters.isEmpty && !viewModel.searchText.isEmpty {
                    VStack {
                        Spacer()
                        Text(viewModel.localizationService.localized("no_results"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                } else {
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
                                    .padding(4)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .refreshable {
                        guard viewModel.searchText.isEmpty else { return }
                        await viewModel.refreshCharacters()
                    }
                }
                if viewModel.isRefreshing {
                    ZStack {
                        Color.black.opacity(0.2).ignoresSafeArea()
                        ProgressView(viewModel.localizationService.localized("refreshing"))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                    }
                    .zIndex(1)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isRefreshing)
                }
            }
            .navigationTitle(viewModel.title)
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: Text(viewModel.localizationService.localized("search_placeholder")))
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}
