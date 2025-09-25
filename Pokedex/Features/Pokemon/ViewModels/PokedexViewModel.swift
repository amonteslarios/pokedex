//
//  Pokedex.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import Foundation
import Combine

final class PokedexViewModel: ObservableObject {
    @Published private(set) var items: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: PokemonAPIServiceProtocol
    private var bag = Set<AnyCancellable>()
    private var offset = 0
    private let pageSize = 50
    private var canLoadMore = true

    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }

    func initialLoad() {
        guard items.isEmpty else { return }
        fetchNextPage()
    }
    
    func refresh() {
        offset = 0
        canLoadMore = true
        items.removeAll()
        fetchNextPage()
    }

    func fetchNextPageIfNeeded(current item: Pokemon?) {
        guard let item = item, canLoadMore, !isLoading else { return }
        let thresholdIndex = max(0, items.count - 10)
        if let idx = items.firstIndex(where: { $0.id == item.id }), idx >= thresholdIndex {
            fetchNextPage()
        }
    }

    func retryLastPage() {
        fetchNextPage()
    }

    private func fetchNextPage() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        errorMessage = nil

        service.list(limit: pageSize, offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case let .failure(err) = completion {
                    self.errorMessage = String(describing: err)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.items.append(contentsOf: response.results)
                self.offset += self.pageSize
                self.canLoadMore = !response.results.isEmpty
            }
            .store(in: &bag)
    }
}

