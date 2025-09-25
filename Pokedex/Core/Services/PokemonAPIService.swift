//
//  PokemonAPIService.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Combine
import Foundation

final class PokemonAPIService: PokemonAPIServiceProtocol {
    private let client: HTTPClientProtocol
    init(client: HTTPClientProtocol = HTTPClient()) { self.client = client }

    func list(limit: Int, offset: Int) -> AnyPublisher<PokemonList, NetworkError> {
        client.request(PokemonEndpoint<PokemonList>.list(limit: limit, offset: offset))
    }

    func detail(id: Int) -> AnyPublisher<PokemonDetail, NetworkError> {
        client.request(PokemonEndpoint<PokemonDetail>.detail(id: id))
    }

    func species(id: Int) -> AnyPublisher<PokemonSpecies, NetworkError> {
        client.request(PokemonEndpoint<PokemonSpecies>.species(id: id))
    }
}
