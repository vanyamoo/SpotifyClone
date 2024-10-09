//
//  RecentsGrid.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 09/10/2024.
//

import SwiftUI

struct RecentsGrid<Item, ItemView>: View where ItemView: View {
    var rows = 4
    var columns = 2
    var items: [Item]
    var content: (Item) -> ItemView
    
    init(rows: Int = 4, columns: Int = 2, items: [Item], @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.rows = rows
        self.columns = columns
        self.items = items
        self.content = content
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows, id: \.self) { row in  // rows
                GridRow {
                    ForEach(0..<columns, id: \.self) { col in // cells
                            content(items[columns * row + col])
                                .padding(4)
                    }
                }
            }
        }
        .padding(6)
    }
}
