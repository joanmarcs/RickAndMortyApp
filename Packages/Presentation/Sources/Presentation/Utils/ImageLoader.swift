//
//  ImageLoader.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var didFail: Bool = false

    private static let cache = NSCache<NSURL, UIImage>()
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        if let cachedImage = Self.cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)

        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode),
                   let image = UIImage(data: data) {
                    Self.cache.setObject(image, forKey: url as NSURL)
                    self.image = image
                }
            } catch {
                self.didFail = true
                print("Image load failed: \(error.localizedDescription)")
            }
        }
    }
}
