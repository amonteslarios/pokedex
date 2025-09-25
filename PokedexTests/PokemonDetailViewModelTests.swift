import XCTest
import Combine
@testable import Pokedex

final class PokemonDetailViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_loadDetailPublishesData() throws {
        struct Detail { let id: Int; let name: String }
        protocol DetailService {
            func fetchDetail(id: Int) -> AnyPublisher<Detail, Error>
        }
        final class StubService: DetailService {
            func fetchDetail(id: Int) -> AnyPublisher<Detail, Error> {
                Just(Detail(id: id, name: "bulbasaur"))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
        final class ViewModel {
            @Published private(set) var name: String = ""
            let service: DetailService
            init(service: DetailService) { self.service = service }
            func load(id: Int) {
                service.fetchDetail(id: id)
                    .map(\.name)
                    .replaceError(with: "")
                    .assign(to: &$name)
            }
        }

        let vm = ViewModel(service: StubService())
        let exp = expectation(description: "name")
        var received = ""

        vm.$name.dropFirst().sink { value in
            received = value; exp.fulfill()
        }.store(in: &cancellables)

        vm.load(id: 1)
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(received, "bulbasaur")
    }
}
