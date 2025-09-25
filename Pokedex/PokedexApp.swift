//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//

import SwiftUI

@main
struct PokedexApp: App {
    private let di = AppDIContainer()

    var body: some Scene {
        WindowGroup {
                    PokedexView(
                        vm: .init(service: di.pokemonService),
                        detailView: { url, name in
                            let id = url
                                .absoluteString
                                .split(separator: "/")
                                .compactMap { Int($0) }
                                .last
                            return AnyView(
                                PokemonDetailView(vm: PokemonDetailViewModel(id: id!, service: di.pokemonService, initialName: name)))                                
                        }
                    )
                }
    }
}
