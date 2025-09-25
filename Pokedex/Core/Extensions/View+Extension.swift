
//
//  View}.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

extension View {
    @ViewBuilder
    func overlayIf<Overlay: View>(_ condition: Bool, alignment: Alignment = .center, @ViewBuilder _ overlay: () -> Overlay) -> some View {
        if condition { self.overlay(overlay(), alignment: alignment) } else { self }
    }
}

