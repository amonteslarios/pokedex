//
//  Endpoints.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation

enum PokemonEndpoint<Response: Decodable>: APIEndpoint {
    case list(limit: Int, offset: Int)
    case detail(id: Int)
    case species(id: Int)

    var baseURL: URL { URL(string: "https://pokeapi.co/api/v2")! }
    var path: String {
        switch self {
        case .list:                  return "/pokemon"
        case .detail(let id):        return "/pokemon/\(id)"
        case .species(let id):       return "/pokemon-species/\(id)"
        }
    }
    var method: HTTPMethod { .GET}
    var queryItems: [URLQueryItem] {
        switch self {
        case let .list(limit, offset):
            return [.init(name: "limit", value: "\(limit)"),
                    .init(name: "offset", value: "\(offset)")]
        default: return []
        }
    }
    var headers: [String: String] {
        ["Accept": "application/json"]
    }

    var body: Data? { nil }
}
typealias PokemonListEP = PokemonEndpoint<PokemonList>
typealias PokemonDetailEP = PokemonEndpoint<PokemonDetail>
typealias PokemonSpeciesEP = PokemonEndpoint<PokemonSpecies>
