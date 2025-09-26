//
//  EmptySearchView.swift
//  Pokedex
//
//  Created by Anthony Montes Larios on 24/09/25.
//
import SwiftUI

struct EmptySearchView: View {
    let query: String
    var suggestions: [String] = []
    var onClear: (() -> Void)?
    let onLoadMore: (() -> Void)? = nil
    let onGlobalSearch: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("Sin resultados para “\(query)”")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Sigue desplazándote para cargar más o intenta una búsqueda global.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if !suggestions.isEmpty {
                           VStack(spacing: 8) {
                               Text("Sugerencias")
                                   .font(.subheadline)
                                   .foregroundStyle(.secondary)
                               WrapChips(items: suggestions) { _ in }
                                   .accessibilityElement(children: .contain)
                           }
                       }

                       if let onClear = onClear {
                           Button("Limpiar búsqueda", action: onClear)
                               .buttonStyle(.bordered)
                               .accessibilityLabel("Limpiar búsqueda")
                       }
                   }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
        .padding()
        .transition(.opacity)
        .accessibilityElement(children: .combine)
    }
}

private struct WrapChips: View {
    let items: [String]
    var onTap: (String) -> Void

    var body: some View {
        FlexibleView(
            data: items,
            spacing: 8,
            alignment: .leading
        ) { item in
            Button(item) { onTap(item) }
                .buttonStyle(.bordered)
                .font(.caption)
        }
    }
}

/// Layout flexible para envolver vistas (multilínea)
private struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    init(data: Data, spacing: CGFloat, alignment: HorizontalAlignment, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        GeometryReader { geo in
            self.generateContent(in: geo)
        }
        .frame(maxWidth: .infinity, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var rows: [[Data.Element]] = [[]]

        for item in data {
            let itemWidth = (item as! NSString).size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .caption1)]).width + 24
            if width + itemWidth + spacing > g.size.width {
                rows.append([item])
                width = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                width += itemWidth + spacing
            }
        }

        return VStack(alignment: alignment, spacing: 8) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}
