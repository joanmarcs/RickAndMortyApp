//
//  CharactersListView.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation
import SwiftUI

public struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel
    @State private var isShowingFilters = false
    
    public init(viewModel: CharacterListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    loadingView
                } else if !viewModel.isLoading && viewModel.characters.isEmpty && !viewModel.searchText.isEmpty {
                    emptyResultsView
                } else {
                    charactersGrid
                }
                
                if viewModel.isRefreshing {
                    refreshingOverlay
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            viewModel.isGrid.toggle()
                        } label: {
                            Image(systemName: viewModel.isGrid
                                  ? "list.bullet"
                                  : "square.grid.3x3.fill")
                            .foregroundColor(.primary)
                        }
                        Button {
                            isShowingFilters = true
                        } label: {
                            Image(systemName: hasActiveFilters
                                  ? "line.horizontal.3.decrease.circle.fill"
                                  : "line.horizontal.3.decrease.circle")
                            .foregroundColor(hasActiveFilters ? .blue : .primary)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: Text(viewModel.localizationService.localized("search_placeholder")))
            .onAppear {
                viewModel.fetchCharacters()
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
            .sheet(isPresented: $isShowingFilters) {
                FiltersView(
                    selectedStatus: $viewModel.selectedStatus,
                    selectedGender: $viewModel.selectedGender,
                    localizationService: viewModel.localizationService
                )
            }
            
        }
        
        
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView(viewModel.localizationService.localized("loading"))
                .padding()
            Spacer()
        }
    }
    
    private var emptyResultsView: some View {
        VStack {
            Spacer()
            Text(viewModel.localizationService.localized("no_results"))
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
    
    private var charactersGrid: some View {
        ScrollView {
            if viewModel.isGrid {
                LazyVGrid(columns: [
                    .init(.flexible()),
                    .init(.flexible()),
                    .init(.flexible())
                ], spacing: 16) {
                    characterItems
                }
                .padding(.horizontal)
                .padding(.top, 16)
            } else {
                LazyVStack(spacing: 8) {
                    characterItems
                }
                .padding(.horizontal)
            }
        }
        .refreshable {
            guard viewModel.searchText.isEmpty else { return }
            await viewModel.refreshCharacters()
        }
    }
    
    private var refreshingOverlay: some View {
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
    }
    
    private var hasActiveFilters: Bool {
        viewModel.selectedStatus != nil || viewModel.selectedGender != nil
    }
    
    private var characterItems: some View {
        ForEach(viewModel.characters, id: \.id) { character in
            let destination = viewModel.coordinator.makeCharacterDetail(for: character.asDomain())
            NavigationLink(destination: destination) {
                if viewModel.isGrid {
                    CharacterView(viewModel: character)
                } else {
                    CharacterRowView(viewModel: character)
                }
            }
            .onAppear {
                if viewModel.hasReachedEnd(of: character) {
                    viewModel.fetchCharacters()
                }
            }
            .padding(4)
        }
    }
    
}

