//
//  EmptySearchView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct EmptySearchView: View {
    let query: String
    let onLoadMore: (() -> Void)? = nil
    let onGlobalSearch: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("Sin resultados para “\(query)”")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Sigue desplazándote para cargar más o intenta una búsqueda global.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack(spacing: 12) {
                if let onLoadMore { Button("Cargar más", action: onLoadMore).buttonStyle(.bordered) }
                if let onGlobalSearch { Button("Buscar globalmente", action: onGlobalSearch).buttonStyle(.borderedProminent) }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
        .padding()
        .transition(.opacity)
        .accessibilityElement(children: .combine)
    }
}
