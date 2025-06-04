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
            ScrollView {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible()), .init(.flexible())]) {
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
            .navigationTitle(viewModel.title)
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}

