//
//  Image+DataInit.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 25/09/25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
public extension Image {
    init?(data: Data) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
#endif
