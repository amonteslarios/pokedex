//
//  PokedexView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import SwiftUI
import Foundation

struct PokedexView: View {
    @StateObject private var vm: PokedexViewModel
    let detailView: (_ detailURL: URL, _ name: String) -> AnyView

    init(vm: PokedexViewModel, detailView:  @escaping (_ detailURL: URL, _ detailname: String) -> AnyView){
        _vm = StateObject(wrappedValue: vm)
        self.detailView = detailView
    }
    @State private var query: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                List(filteredItems, id: \.id) { pokemon in
                    let row = PokemonRowView(pokemon: pokemon)
                        .onAppear { vm.fetchNextPageIfNeeded(current: pokemon) }
                        .listRowSeparator(.hidden)
                    if let url = URL(string: pokemon.url) {
                        NavigationLink {
                            detailView(url, pokemon.name)
                        } label: {
                            row
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    } else {
                        row.contentShape(Rectangle())
                            .disabled(true)
                            .opacity(0.6)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokédex")
                .searchable(text: $query, placement: .navigationBarDrawer, prompt: "Buscar Pokémon")
                .refreshable { vm.refresh() }
                if vm.isLoading && vm.items.isEmpty {
                    LoadingOverlay(text: "Cargando Pokémon…")
                    .zIndex(1)
                }
                if let msg = vm.errorMessage, vm.items.isEmpty {
                    ErrorView(
                        message: msg,
                        onRetry: { vm.retryLastPage() }
                    )
                }
            }
            .onAppear { vm.initialLoad() }
        }
    }

    private var filteredItems: [Pokemon] {
        guard !query.isEmpty else { return vm.items }
        return vm.items.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
