//
//  TypeChip.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct TypeChip: View {
    let text: String
    var body: some View {
        Text(text.uppercased())
            .font(.caption).bold()
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(colorForType(text))
            .cornerRadius(Radius.md)
            .accessibilityLabel("Tipo \(text)")
    }

    private func colorForType(_ t: String) -> Color {
        switch t.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "ice": return .cyan
        case "psychic": return .purple
        case "dark": return .black
        case "fairy": return .pink
        case "bug": return .purple
        default: return .gray
        }
    }
}
