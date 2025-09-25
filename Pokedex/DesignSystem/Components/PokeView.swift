//
//  PokeView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 23/09/25.
//
import SwiftUI

struct PokeView: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text.uppercased())
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(card)
            .cornerRadius(8)
    }
}

struct PokeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            PokeView(text: "Electric", color: .yellow)
            PokeView(text: "Fire", color: .red)
            PokeView(text: "Water", color: .blue)
        }
    }
}

struct StatsGrid: View {
    let hp: Int?, attack: Int?, defense: Int?

    var cols: [GridItem] = [.init(.flexible()), .init(.flexible()), .init(.flexible())]

    var body: some View {
        LazyVGrid(columns: [.init(.flexible()), .init(.flexible()), .init(.flexible())], spacing: Spacing.md) {
            StatCard(title: "HP",      value: hp,     symbol: "heart.fill")
            StatCard(title: "Ataque",  value: attack, symbol: "bolt.fill")
            StatCard(title: "Defensa", value: defense, symbol: "shield.lefthalf.filled")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: Int?
    let symbol: String

    var body: some View {
        VStack(spacing: Spacing.xs) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: symbol)
                Text(title)
            }
            .font(.caption)
            .foregroundColor(.secondary)

            Text(value.map(String.init) ?? "—")
                .font(.title3).bold()
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct InfoGrid: View {
    let items: [(String, String)]
    var cols: [GridItem] = [.init(.flexible()), .init(.flexible())]

    var body: some View {
        LazyVGrid(columns: cols, spacing: 12) {
            ForEach(items, id: \.0) { k, v in
                VStack(spacing: 4) {
                    Text(k).font(.caption).foregroundColor(.secondary)
                    Text(v).font(.body).bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
    }
}
