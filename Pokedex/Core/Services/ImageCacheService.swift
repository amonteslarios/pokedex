//
//  ImageCacheService.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import UIKit
import Combine

final class ImageCacheService: ImageCacheServiceProtocol {
    static let shared = ImageCacheService()
    private let cache = NSCache<NSURL, UIImage>()
    private let queue = DispatchQueue(label: "ImageCacheService", qos: .userInitiated)
    func image(for url: URL) -> UIImage? { cache.object(forKey: url as NSURL) }
    func setImage(_ image: UIImage, for url: URL) { cache.setObject(image, forKey: url as NSURL) }
    func clear() { cache.removeAllObjects() }

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let cached = cache.object(forKey: url as NSURL) {
            return Just(cached).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map { data, _ in UIImage(data: data) }
            .handleEvents(receiveOutput: { [weak self] image in
                guard let self, let image else { return }
                self.cache.setObject(image, forKey: url as NSURL)
            })
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}





