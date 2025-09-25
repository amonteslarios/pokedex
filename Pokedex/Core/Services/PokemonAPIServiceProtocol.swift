//
//  PokemonAPIServiceProtocol.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Combine
import Foundation

protocol PokemonAPIServiceProtocol {
    func list(limit: Int, offset: Int) -> AnyPublisher<PokemonList, NetworkError>
    func detail(id: Int) -> AnyPublisher<PokemonDetail, NetworkError>
    func species(id: Int) -> AnyPublisher<PokemonSpecies, NetworkError>
}
