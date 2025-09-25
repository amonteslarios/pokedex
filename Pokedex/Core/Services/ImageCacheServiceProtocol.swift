//
//  Untitled.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import UIKit
import Combine

protocol ImageCacheServiceProtocol {
    func image(for url: URL) -> UIImage?
    func setImage(_ image: UIImage, for url: URL)
    func clear()
}
