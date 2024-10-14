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
    @State private var showHeader = false
    
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
//                    .background(
//                        GeometryReader { geometry in
//                            Text("")
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        }
//                    )
                    // this is equivalent to the .background(...) above
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150 // frame.maxY is the bottom of the PlaylistHeaderCell
                    }
                    
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
            
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.spotifyBlack)
                    .offset(y: showHeader ? 0 : -40)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? Color.black.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                        //
                    }
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.spotifyWhite)
            .animation(.smooth(duration: 0.2), value: showHeader)
            
            .frame(maxHeight: .infinity, alignment: .top)
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
