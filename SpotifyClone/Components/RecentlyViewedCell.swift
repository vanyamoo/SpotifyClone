//
//  RecentlyViewedCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 09/10/2024.
//

import SwiftUI

struct RecentlyViewedCell: View {
    
    var title = "Father John Misty"
    var imageName = Constants.randomImage
    
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
                .background(.spotifyWhite)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            HStack {
                RecentlyViewedCell(title: "The Lumineers")
                RecentlyViewedCell(title: "Father John Misty")
            }
            HStack {
                RecentlyViewedCell(title: "SYML")
                RecentlyViewedCell(title: "Vampire Weekend")
            }
            
        }
    }
}
