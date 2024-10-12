//
//  SongRowCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 12/10/2024.
//

import SwiftUI

struct SongRowCell: View {
    var imageName = Constants.randomImage
    var imageSize: CGFloat = 65
    var title = "Title goes here"
    var subtitle: String? = "Subtitle goes here"
    var onEllipsisPressed: (() -> Void)?
    var onCellPressed: (() -> Void)?
    
    var body: some View {
        HStack {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundStyle(.spotifyWhite)
                    .fontWeight(.medium)
                    //.padding(.vertical, 4)
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                }
                
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ellipsis
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
            
        }
        .onTapGesture {
            onCellPressed?()
        }
        
    }
    
    private var ellipsis: some View {
        Image(systemName: "ellipsis")
            .padding()
            .background(.black.opacity(0.01))
            .onTapGesture {
                onCellPressed?()
            }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
        
    }
    
}
