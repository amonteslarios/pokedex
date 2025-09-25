import XCTest
@testable import Pokedex

final class ModelsDecodingTests: XCTestCase {

    func test_decodePokemonListResponse() throws {
        let json = """
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
          "previous": null,
          "results": [
            {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
            {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
          ]
        }
        """.data(using: .utf8)!

        // Replace PokemonListResponse with your actual type
        struct PokemonListResponse: Decodable {
            struct Entry: Decodable { let name: String; let url: String }
            let count: Int
            let next: String?
            let previous: String?
            let results: [Entry]
        }

        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: json)
        XCTAssertEqual(decoded.count, 1302)
        XCTAssertEqual(decoded.results.first?.name, "bulbasaur")
        XCTAssertEqual(decoded.results[1].url, "https://pokeapi.co/api/v2/pokemon/2/")
    }

    func test_decodePokemonDetail() throws {
        let json = """
        {
          "id": 1,
          "name": "bulbasaur",
          "height": 7,
          "weight": 69,
          "types": [
            {"slot": 1, "type": {"name": "grass", "url": "https://pokeapi.co/api/v2/type/12/"}}
          ],
          "stats": [
            {"base_stat": 45, "effort": 0, "stat": {"name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/"}}
          ]
        }
        """.data(using: .utf8)!

        // Replace Pokemon with your actual model type
        struct Pokemon: Decodable {
            struct NamedRef: Decodable { let name: String; let url: String }
            struct TypeEntry: Decodable { let slot: Int; let type: NamedRef }
            struct StatEntry: Decodable { let base_stat: Int; let effort: Int; let stat: NamedRef }
            let id: Int
            let name: String
            let height: Int
            let weight: Int
            let types: [TypeEntry]
            let stats: [StatEntry]
        }

        let decoded = try JSONDecoder().decode(Pokemon.self, from: json)
        XCTAssertEqual(decoded.id, 1)
        XCTAssertEqual(decoded.types.first?.type.name, "grass")
        XCTAssertEqual(decoded.stats.first?.base_stat, 45)
    }
}
