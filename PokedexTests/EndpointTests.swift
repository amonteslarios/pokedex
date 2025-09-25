import XCTest
@testable import Pokedex

final class EndpointTests: XCTestCase {

    func test_buildPokemonListURL() throws {
        // If you have an Endpoint enum, adapt this accordingly.
        func makeListURL(offset: Int, limit: Int) -> URL {
            var comps = URLComponents(string: "https://pokeapi.co/api/v2/pokemon")!
            comps.queryItems = [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            return comps.url!
        }

        let url = makeListURL(offset: 40, limit: 20).absoluteString
        XCTAssertEqual(url, "https://pokeapi.co/api/v2/pokemon?offset=40&limit=20")
    }
}
