//
//  Detail.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation

struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [TypeElement]
    let stats: [StatElement]
    let species: NamedAPIResource
    
    struct Sprites: Decodable {
        let front_default: String?
        let other: Other?

        struct Other: Decodable {
            let official_artwork: OfficialArtwork?

            enum CodingKeys: String, CodingKey {
                case official_artwork = "official-artwork"
            }

            struct OfficialArtwork: Decodable {
                let front_default: String?
            }
        }
    }
    
    struct StatElement: Decodable {
        let base_stat: Int
        let stat: NamedAPIResource
    }

    struct TypeElement: Decodable {
        let slot: Int
        let type: NamedAPIResource
    }
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

extension PokemonDetail {
    var officialArtworkURL: URL? {
        if let s = sprites.other?.official_artwork?.front_default {
            return URL(string: s)
        }
        if let s = sprites.front_default {
            return URL(string: s)
        }
        return nil
    }
    var typeNames: [String] { types.sorted { $0.slot < $1.slot }.map { $0.type.name } }

    private func stat(_ key: String) -> Int? { stats.first { $0.stat.name == key }?.base_stat }

    var hp: Int?      { stat("hp") }
    var attack: Int?  { stat("attack") }
    var defense: Int? { stat("defense") }

    var heightMeters: Double { Double(height) / 10.0 }
    var weightKg: Double { Double(weight) / 10.0 }
}
