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
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                HStack {
                    AsyncImage(url: URL(string: character.imageURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().frame(width: 50, height: 50).clipShape(Circle())
                        default:
                            ProgressView()
                        }
                    }
                    Text(character.name)
                }
            }
            .navigationTitle(viewModel.title)
            .task {
                await viewModel.loadCharacters()
            }
        }
    }
}
