//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import SwiftUI

import SwiftUI

struct CharacterView: View {
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        VStack {
            if let url = URL(string: viewModel.imageURL) {
                RemoteImageView(
                    url: url,
                    placeholder: {
                        ProgressView()
                            .frame(height: 120)
                    },
                    errorView: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                )
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Text(viewModel.name)
                .font(.headline)
                .lineLimit(1)
        }
    }
}

#Preview {
    CharacterView(viewModel: CharacterViewModel(
        id: 1,
        name: "Rick Sanchez",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    ))
}
