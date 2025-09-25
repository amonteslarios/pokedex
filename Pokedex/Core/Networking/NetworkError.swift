//
//  NetworkError.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
enum NetworkError: Error {
    case invalidResponse
    case http(Int)
    case decoding(Error)
    case transport(Error)
}
