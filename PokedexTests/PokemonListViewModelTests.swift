import XCTest
import Combine
@testable import Pokedex

final class PokemonListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_initialLoadPublishesFirstPage() throws {
        // Example ViewModel contract assumed; adapt to your real API.
        protocol PokemonListing {
            func fetchPage(offset: Int, limit: Int) -> AnyPublisher<[String], Error>
        }

        final class StubService: PokemonListing {
            func fetchPage(offset: Int, limit: Int) -> AnyPublisher<[String], Error> {
                let names = ["bulbasaur", "ivysaur", "venusaur"]
                return Just(names).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
        }

        final class PokemonListViewModel {
            @Published private(set) var items: [String] = []
            let service: PokemonListing
            init(service: PokemonListing) { self.service = service }
            func load() {
                service.fetchPage(offset: 0, limit: 20)
                    .replaceError(with: [])
                    .assign(to: &$items)
            }
        }

        let vm = PokemonListViewModel(service: StubService())
        let exp = expectation(description: "items")
        var result: [String] = []

        vm.$items.dropFirst().sink { value in
            result = value; exp.fulfill()
        }.store(in: &cancellables)

        vm.load()
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(result.prefix(3), ["bulbasaur", "ivysaur", "venusaur"])
    }
}
