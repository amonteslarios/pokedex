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
            CachedAsyncImage(url: pokemon.frontSpriteURL)
                .frame(width: 56, height: 56)
                .foregroundColor(.secondary)
                .background(card)
                .clipShape(RoundedRectangle(cornerRadius: 12))        
            VStack(alignment: .leading, spacing: 2) {
                Text(pokemon.name.capitalized)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Text(pokemon.formattedID)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .minimumScaleFactor(0.75)                
            }
            Spacer()
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(pokemon.name), \(pokemon.formattedID)")
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonRowView(pokemon: .init(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/"))
                .previewDisplayName("Light")
            PokemonRowView(pokemon: .init(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"))
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("")
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
