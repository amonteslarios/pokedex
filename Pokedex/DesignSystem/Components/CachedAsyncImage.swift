//
//  CachedAsyncImage.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @State private var data: Data?

    var body: some View {
        Group {
            if let data, let image = Image(data: data) {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .task {
                        if #available(iOS 15.0, macOS 12.0, *) {
                            data = await ImageCacheService.shared.loadData(from: url)
                        } else {
                            // Fallback a Combine si necesitas soportar iOS <15
                        }
                    }
            }
        }
    }
}

