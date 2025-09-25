//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var title: String
    @Published var detail: PokemonDetail?
    @Published private(set) var descriptionText: String = ""
    @Published var species: PokemonSpecies?
    @Published var imageURL: URL?
    @Published var hp: Int?
    @Published var attack: Int?
    @Published var defense: Int?
    @Published var types: [String] = []
    @Published var heightText: String = "—"
    @Published var weightText: String = "—"
    @Published var flavorText: String = "—"
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: PokemonAPIServiceProtocol
    private let pokemonID: Int
    private var bag = Set<AnyCancellable>()

    init(id: Int, service: PokemonAPIServiceProtocol, initialName: String) {
        self.pokemonID = id
        self.service = service
        self.title = initialName.capitalized
    }

    func load() {
        guard !isLoading else { return }
          isLoading = true
          errorMessage = nil
            service.detail(id: pokemonID)
              .flatMap { [weak self] detail -> AnyPublisher<(PokemonDetail, PokemonSpecies?), NetworkError> in
                  guard let self = self else {
                      return Just((detail, nil))
                          .setFailureType(to: NetworkError.self)
                          .eraseToAnyPublisher()
                  }
                  if let speciesID = Self.extractID(from: detail.species.url) {
                      return self.service.species(id: speciesID)
                          .map { (detail, Optional($0)) }
                          .eraseToAnyPublisher()
                  } else {
                      return Just((detail, nil))
                          .setFailureType(to: NetworkError.self)
                          .eraseToAnyPublisher()
                  }
              }
              .receive(on: DispatchQueue.main)
              .sink { [weak self] completion in
                  guard let self = self else { return }
                  self.isLoading = false
                  if case let .failure(err) = completion {
                      self.errorMessage = humanize(err)
                  }
              } receiveValue: { [weak self] detail, species in
                  guard let self = self else { return }
                  self.detail = detail
                  self.imageURL = detail.officialArtworkURL
                  self.additionalData(detail: detail, species: species)
                  self.species = species
              }
              .store(in: &bag)
    }
    
    func retry() { load() }
    
    private func additionalData(detail: PokemonDetail, species: PokemonSpecies?) {
        hp = detail.hp; attack = detail.attack; defense = detail.defense
        types = detail.typeNames.map { $0.capitalized }
        heightText = String(format: "%.1f m", detail.heightMeters)
        weightText = String(format: "%.1f kg", detail.weightKg)

        if let txt = species?
            .flavor_text_entries
            .first(where: { $0.language.name == "es" || $0.language.name == "en" })?
            .flavor_text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000C}", with: " ") {
            flavorText = txt
        } else {
            flavorText = "—"
        }
    }
    
    private func humanize(_ err: NetworkError) -> String {
        switch err {
        case .invalidResponse: return "Respuesta inválida del servidor."
        case .http(let code):  return "Error de red (\(code)). Intenta nuevamente."
        case .decoding:        return "No se pudo interpretar la información."
        case .transport:       return "Sin conexión o tiempo de espera agotado."
        }
    }
    
    private static func extractID(from urlString: String) -> Int? {
        urlString.split(separator: "/").compactMap { Int($0) }.last
    }
}

