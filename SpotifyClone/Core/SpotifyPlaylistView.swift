//
//  SpotifyPlaylistView.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 11/10/2024.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    @State private var user: User = .mock
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "",
                        imageName: product.firstImage
                    )
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.brand ?? "",
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageName: product.firstImage,
                            imageSize: 65,
                            title: product.title,
                            subtitle: product.brand,
                            onEllipsisPressed: {
                                //
                            },
                            onCellPressed: nil
                        )
                        .padding(.leading)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await getAllSongsFromAlbum()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getAllSongsFromAlbum() async {
        do {
            user = try await DatabaseHelper().getUsers().first ?? .mock
            products = try await DatabaseHelper().getProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
