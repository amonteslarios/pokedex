//
//  AppDIContainer.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
/// - Note: Extiende este contenedor para registrar nuevos servicios.
/// - SeeAlso: `PokemonAPIService`, `HTTPClient`
struct AppDIContainer {
    /// Cliente HTTP compartido para toda la app.
    let http = HTTPClient()
    /// Servicio de dominio para consumir la PokéAPI.
    var pokemonService: PokemonAPIServiceProtocol { PokemonAPIService(client: http) }
}
