//
//  NetworkError.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
enum NetworkError: Error {
    /// Fallo al formar la URL/Request.
    case invalidResponse
    /// Código HTTP no exitoso (4xx/5xx).
    case http(Int)
    /// JSON inesperado o incompatible con el modelo.
    case decoding(Error)
    /// Error de transporte (sin red, TLS, etc.)
    case transport(Error)
}
