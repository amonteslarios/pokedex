//
//  AsyncImageView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: AnyView
    private let image: (Image) -> Image

    init(
        url: URL?,
        @ViewBuilder image: @escaping (Image) -> Image = { $0 },
        @ViewBuilder placeholder: @escaping () -> AnyView = { AnyView(ProgressView()) }
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.image = image
        self.placeholder = placeholder()
    }

    var body: some View {
        content
            .onAppear { loader.load() }
    }

    private var content: some View {
        Group {
            if let uiImage = loader.image {
                image(Image(uiImage: uiImage))
            } else {
                placeholder
            }
        }
    }
}

// MARK: - Loader con cache
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSURL, UIImage>()

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url else { return }

        if let cached = Self.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self, let img = $0 else { return }
                Self.cache.setObject(img, forKey: url as NSURL)
                self.image = img
            }
    }
    deinit { cancellable?.cancel() }
}
