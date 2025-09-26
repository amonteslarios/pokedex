//
//  ErrorView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 25/09/25.
//
import SwiftUI

struct ErrorView: View {
    let message: String
    var onRetry: (() -> Void)?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .imageScale(.large)
                .font(.system(size: 40))
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            if let onRetry = onRetry {
                Button("Retry", action: onRetry)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}
