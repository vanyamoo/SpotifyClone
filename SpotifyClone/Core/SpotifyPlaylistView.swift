//
//  SpotifyPlaylistView.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 11/10/2024.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView {
                LazyVStack {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.description,
                        imageName: product.firstImage
                    )
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
