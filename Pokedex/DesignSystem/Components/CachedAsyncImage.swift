//
//  CachedAsyncImage.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI
import Combine

struct CachedAsyncImage: View {
    let url: URL?
    @State private var image: UIImage?
    @State private var cancellable: AnyCancellable?
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    private func loadImage() {
        guard let url else { return }
        cancellable = ImageCacheService.shared
            .loadImage(from: url)
            .sink { img in
                self.image = img
            }
    }
}

