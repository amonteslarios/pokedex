//
//  APIEndpoint.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation

protocol APIEndpoint {
    associatedtype Response: Decodable    
    var baseURL: URL { get }
    var path: String { get }
    /// Método HTTP a usar.
    var method: HTTPMethod { get }
    /// Parámetros de query opcionales.
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}
