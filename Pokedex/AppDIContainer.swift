//
//  AppDIContainer.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
struct AppDIContainer {
    let http = HTTPClient()
    var pokemonService: PokemonAPIServiceProtocol { PokemonAPIService(client: http) }
}
