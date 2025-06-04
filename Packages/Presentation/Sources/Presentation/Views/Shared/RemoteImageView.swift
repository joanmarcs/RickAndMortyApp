//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import SwiftUI

//public struct RemoteImageView: View {
//    private let url: URL
//    @StateObject private var loader: ImageLoader
//
//    public init(url: URL) {
//        self.url = url
//        _loader = StateObject(wrappedValue: ImageLoader(url: url))
//    }
//
//    public var body: some View {
//        content
//            .onAppear { loader.load() }
//    }
//
//    @ViewBuilder
//    private var content: some View {
//        if let image = loader.image {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFill()
//        } else {
//            ProgressView()
//        }
//    }
//}

public struct RemoteImageView<Placeholder: View, ErrorView: View>: View {
    private let url: URL
    private let placeholder: () -> Placeholder
    private let errorView: () -> ErrorView

    @StateObject private var loader: ImageLoader

    public init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder errorView: @escaping () -> ErrorView
    ) {
        self.url = url
        self.placeholder = placeholder
        self.errorView = errorView
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    public var body: some View {
        content
            .onAppear { loader.load() }
    }

    @ViewBuilder
    private var content: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else if loader.didFail {
            errorView()
        } else {
            placeholder()
        }
    }
}
