import Foundation
import XCTest
import Combine

func makeURLSessionWithMock() -> URLSession {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: config)
}

extension XCTestCase {
    /// Waits for a publisher to complete and returns its output / error.
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 2.0,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> T.Output {
        var output: T.Output?
        var failure: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        let cancellable = publisher.sink { completion in
            if case let .failure(err) = completion {
                failure = err
            }
            expectation.fulfill()
        } receiveValue: { value in
            output = value
        }
        waitForExpectations(timeout: timeout)
        _ = cancellable // keep alive
        if let failure = failure { throw failure }
        return try XCTUnwrap(output, file: file, line: line)
    }
}
