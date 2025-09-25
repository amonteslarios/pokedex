//
//  PokemonAPIServiceProtocol.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Combine
import Foundation

protocol PokemonAPIServiceProtocol {
    /// Obtiene una página de la lista de Pokémon.
    func list(limit: Int, offset: Int) -> AnyPublisher<PokemonList, NetworkError>
    /// Obtiene el detalle de un Pokémon.
    func detail(id: Int) -> AnyPublisher<PokemonDetail, NetworkError>
    /// Obtiene la especie de un Pokémon.
    func species(id: Int) -> AnyPublisher<PokemonSpecies, NetworkError>
}
