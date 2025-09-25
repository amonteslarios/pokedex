//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm: PokemonDetailViewModel
    init(vm: PokemonDetailViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        Group {
            if vm.isLoading && vm.imageURL == nil {
                VStack {
                    ProgressView("Cargando Pokémon…")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            } else if let msg = vm.errorMessage, vm.imageURL == nil {
                // Error inicial sin datos: muestra tarjeta con retry
                ErrorStateView(
                    title: "No se pudo cargar el detalle",
                    message: msg,
                    retryTitle: "Reintentar",
                    onRetry: { vm.retry() }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        HeroImageView(url: vm.imageURL)
                        Text(vm.title).font(.largeTitle).bold()
                        if !vm.types.isEmpty {
                          HStack(spacing: 8) {
                              ForEach(vm.types, id: \.self) { t in
                                  TypeChip(text: t)                                 
                              }
                          }
                          .padding(.horizontal)
                        }
                        StatsGrid(hp: vm.hp, attack: vm.attack, defense: vm.defense)
                            .padding(.horizontal)
                        InfoGrid(items: [
                            ("Altura", vm.heightText),
                            ("Peso",   vm.weightText)
                        ])
                        .padding(.horizontal)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Descripción").font(.headline)
                            Text(vm.flavorText).foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        if let msg = vm.errorMessage { Text(msg).foregroundColor(.red) }
                        if vm.isLoading { ProgressView().padding(.top, 4) }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                }
            }
        }
        .navigationTitle(vm.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.load() }
    }
}
