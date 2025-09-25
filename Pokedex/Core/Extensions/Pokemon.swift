//
//  Pokemon.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import Foundation

extension Pokemon {
    var numericID: Int? {
        url.split(separator: "/").compactMap { Int($0) }.last
    }

    var formattedID: String {
        guard let id = numericID else { return "—" }
        return String(format: "#%03d", id) // #001, #025, #133
    }

    var frontSpriteURL: URL? {
        guard let id = numericID else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}

