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
                        data = await ImageCacheService.shared.loadData(from: url)
                    }
            }
        }
    }
}

