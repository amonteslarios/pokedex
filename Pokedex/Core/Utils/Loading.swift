//
//  Loading.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct LoadingOverlay: View {
    let text: String
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 8) {
                ProgressView()
                Text(text).font(.footnote).foregroundColor(.secondary)
            }
            .padding(16)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
        .transition(.opacity)
        .accessibilityHidden(false)
        .accessibilityLabel(Text(text))
    }
}
