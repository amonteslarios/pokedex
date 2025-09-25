//
//  Colors.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import SwiftUI

enum AppColors {
    static let primary = Color("Primary")       // definido en Assets.xcassets
    static let secondary = Color("Secondary")
    static let background = Color("Background")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")

    // Colores específicos para tipos de Pokémon
    static let typeColors: [String: Color] = [
        "fire": .red,
        "water": .blue,
        "grass": .green,
        "electric": .yellow,
        "psychic": .purple,
        "ice": .cyan,
        "dragon": .orange,
        "dark": .black,
        "fairy": .pink,
        "normal": .gray
    ]
}

enum Spacing {
    static let xs: CGFloat = 6
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
}

enum Radius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
}

let textPrimary = Color.primary
let textSecondary = Color.secondary
let bg = Color(.systemBackground)
let card = Color(.secondarySystemBackground)

