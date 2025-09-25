import XCTest
import Combine
@testable import Pokedex

final class NetworkClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_client_success() throws {
        let session = makeURLSessionWithMock()

        // Arrange mock response
        let expectedJSON = #"{"ok":true}"#.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            XCTAssertTrue(url.absoluteString.contains("https://pokeapi.co/api/v2/pokemon"))
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedJSON)
        }

        // Assume you have a PokeAPIClient that takes URLSession
        // Replace with your real client/service
        struct PokeAPIClient {
            let session: URLSession
            func get(url: URL) -> AnyPublisher<Data, URLError> {
                session.dataTaskPublisher(for: url).map(\.data).eraseToAnyPublisher()
            }
        }
        let client = PokeAPIClient(session: session)

        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20")!
        let data = try awaitPublisher(client.get(url: url))
        let decoded = try JSONSerialization.jsonObject(with: data) as? [String: Bool]
        XCTAssertEqual(decoded?["ok"], true)
    }

    func test_client_httpError() throws {
        let session = makeURLSessionWithMock()

        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        struct PokeAPIClient {
            enum ClientError: Error { case badStatusCode(Int) }
            let session: URLSession
            func get(url: URL) -> AnyPublisher<Data, Error> {
                session.dataTaskPublisher(for: url)
                    .tryMap { output in
                        guard let http = output.response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                            let code = (output.response as? HTTPURLResponse)?.statusCode ?? -1
                            throw ClientError.badStatusCode(code)
                        }
                        return output.data
                    }.eraseToAnyPublisher()
            }
        }

        let client = PokeAPIClient(session: session)
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20")!

        var receivedError: Error?
        let exp = expectation(description: "error")
        client.get(url: url).sink { completion in
            if case let .failure(err) = completion { receivedError = err; exp.fulfill() }
        } receiveValue: { _ in
            XCTFail("Should not succeed")
        }.store(in: &cancellables)

        waitForExpectations(timeout: 2)
        XCTAssertNotNil(receivedError)
    }
}
