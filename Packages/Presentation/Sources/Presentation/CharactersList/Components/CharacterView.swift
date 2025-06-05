//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var viewModel: CharacterViewModel
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 8) {
            if let url = URL(string: viewModel.imageURL) {
                RemoteImageView(
                    url: url,
                    placeholder: {
                        ProgressView()
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                    },
                    errorView: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                    }
                )
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
            }

            Text(viewModel.name)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 40, alignment: .center)
                .minimumScaleFactor(0.6)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .scaleEffect(appeared ? 1 : 0.95)
        .opacity(appeared ? 1 : 0)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                appeared = true
            }
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
