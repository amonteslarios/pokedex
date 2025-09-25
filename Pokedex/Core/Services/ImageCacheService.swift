//
//  ImageCacheService.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import Foundation
import Combine

protocol ImageCacheServiceProtocol: AnyObject {
    func data(for url: URL) -> Data?
    func setData(_ data: Data, for url: URL)
    func clear()
    func loadData(from url: URL) -> AnyPublisher<Data?, Never>

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    func loadData(from url: URL) async -> Data?
}


final class ImageCacheService: ImageCacheServiceProtocol {
    static let shared = ImageCacheService()

    private let cache = NSCache<NSURL, NSData>()
    private let queue = DispatchQueue(label: "ImageCacheService", qos: .userInitiated)

    private init() {}

    // MARK: - Synchronous cache API
    func data(for url: URL) -> Data? {
        cache.object(forKey: url as NSURL) as Data?
    }

    func setData(_ data: Data, for url: URL) {
        cache.setObject(data as NSData, forKey: url as NSURL)
    }

    func clear() {
        cache.removeAllObjects()
    }

    // MARK: - Combine
    func loadData(from url: URL) -> AnyPublisher<Data?, Never> {
        if let cached = data(for: url) {
            return Just(cached).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map(\.data)
            .handleEvents(receiveOutput: { [weak self] data in
                self?.setData(data, for: url)
            })
            .map { Optional.some($0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - async/await (opcional)
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    func loadData(from url: URL) async -> Data? {
        if let cached = data(for: url) { return cached }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            setData(data, for: url)
            return data
        } catch {
            return nil
        }
    }
}
