//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
struct PokemonList: Decodable {
    let count: Int
    let results: [Pokemon]
}

struct Pokemon: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}
