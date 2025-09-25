//
//  HeroImageView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct HeroImageView: View {
    let url: URL?
    let height: CGFloat = 240
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .frame(height: height)

            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: height)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .transition(.opacity)
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                        .frame(height: height)
                @unknown default:
                    EmptyView().frame(height: height)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: url) 
    }
}

