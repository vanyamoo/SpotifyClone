//
//  Image Title RowCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 10/10/2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageName = Constants.randomImage
    var productTitle: String = "Some Item Name"
    var imageSize: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(productTitle)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        HStack {
            ImageTitleRowCell()
            ImageTitleRowCell()
            ImageTitleRowCell()
        }
        .padding(.horizontal, 20)
    }
    
    
}
