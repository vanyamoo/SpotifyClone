//
//  CategoryCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 08/10/2024.
//

import SwiftUI

struct CategoryCell: View {
    
    var title = "Music"
    var isSelected = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            CategoryCell(title: "Title goes here")
                .frame(width: .infinity, height: 50)
            CategoryCell(title: "Title goes here", isSelected: true)
                .frame(width: .infinity, height: 50)
            CategoryCell(isSelected: true)
                .frame(width: .infinity, height: 50)
        }
        
    }
    
}
