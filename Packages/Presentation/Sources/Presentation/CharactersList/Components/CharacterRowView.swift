//
//  CharacterRowView.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import SwiftUI

struct CharacterRowView: View {
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: viewModel.imageURL) {
                RemoteImageView(
                    url: url,
                    placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    },
                    errorView: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                )
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .clipped()
            }

            Text(viewModel.name)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(1)

            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
