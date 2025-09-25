//
//  RequestBuilder.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation

struct RequestBuilder {
    func buildRequest<E: APIEndpoint>(_ endpoint: E) -> URLRequest {
        var comps = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )!
        comps.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        var req = URLRequest(url: comps.url!)
        req.httpMethod = endpoint.method.rawValue
        req.httpBody = endpoint.body
        endpoint.headers.forEach { req.setValue($1, forHTTPHeaderField: $0) }
        return req
    }
}
