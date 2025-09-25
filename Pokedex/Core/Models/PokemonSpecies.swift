//
//  Species.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
struct PokemonSpecies: Decodable, Identifiable {
    let id: Int
    let name: String
    let flavor_text_entries: [Flavor]
    struct Flavor: Decodable { let flavor_text: String; let language: Lang }
    struct Lang: Decodable { let name: String }
}
