//
//  PokemonRowView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.tertiarySystemFill))
                if let url = pokemon.frontSpriteURL {
                    CachedAsyncImage(url: url)
                    .frame(width: 56, height: 56)
                    .foregroundColor(.secondary)
                } else {
                    Image("spritePlaceholder")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 64, height: 64)
                
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                Text(pokemon.formattedID)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .minimumScaleFactor(0.9)                
            }
            Spacer()
        }
        .padding(12)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(UIColor.separator).opacity(0.15), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous)) // toque cómodo
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(pokemon.name), \(pokemon.formattedID)")
    }
    
    private var cardBackground: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.secondarySystemBackground)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonRowView(pokemon: .init(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/"))
                .previewDisplayName("Light")
            PokemonRowView(pokemon: .init(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/1/"))
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("")
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
