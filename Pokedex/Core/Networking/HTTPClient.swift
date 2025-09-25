//
//  Untitled.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Combine
import Foundation

protocol HTTPClientProtocol {
    func request<E: APIEndpoint>(_ endpoint: E) -> AnyPublisher<E.Response, NetworkError>
}

final class HTTPClient: HTTPClientProtocol {
    func request<E: APIEndpoint>(_ endpoint: E) -> AnyPublisher<E.Response, NetworkError> {
        var components = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )!
        components.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        guard let url = components.url else {
            return Fail(error: .invalidResponse).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let http = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard (200..<300).contains(http.statusCode) else {
                    throw NetworkError.http(http.statusCode)
                }
                return output.data
            }
            .decode(type: E.Response.self, decoder: JSONDecoder())
            .mapError { error in
                if let e = error as? DecodingError { return .decoding(e) }
                if let e = error as? NetworkError { return e }
                return .transport(error)
            }
            .eraseToAnyPublisher()
    }
}

enum HTTPMethod: String { case GET, POST, PUT, PATCH, DELETE }
