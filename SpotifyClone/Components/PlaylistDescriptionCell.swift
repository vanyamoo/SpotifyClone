//
//  PlaylistDescriptionCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 11/10/2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    var descriptionText: String = Product.mock.description
    var userName: String = "Terry"
    var subheadline: String = "Electronic Devices"
    var onAddToPlaylistPressed: (() -> Void)?
    var onDownloadPressed: (() -> Void)?
    var onSharePressed: (() -> Void)?
    var onEllipsisPressed: (() -> Void)?
    var onShufflePressed: (() -> Void)?
    var onPlayPressed: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(descriptionText)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image(systemName: "applelogo")
                    .font(.title3)
                    .foregroundStyle(.spotifyGreen)
//                Text("☘︎")
//                    .font(.largeTitle)
                madeForYouSection
                
            }
            Text(subheadline).font(.title3)
            buttonsRow
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    private var madeForYouSection: some View {
        Text("Made for ")
        +
        Text(userName)
            .bold()
            //.font(.title3)
            .foregroundStyle(.spotifyWhite)
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            leftButtons
                .offset(x: -8)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            playButtons
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
    
    private var leftButtons: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus.circle")
                .padding()
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
            Image(systemName: "arrow.down.circle")
                .padding()
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
            Image(systemName: "square.and.arrow.up")
                .padding()
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
            Image(systemName: "ellipsis")
                .padding()
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
        }
        
    }
    
    private var playButtons: some View {
        HStack {
            Image(systemName: "shuffle")
                .font(.system(size: 24))
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
            Image(systemName: "play.circle.fill")
                .font(.system(size: 46))
                .background(.black.opacity(0.01))
                .onTapGesture {
                    //
                }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
            .padding()
    }
    
}
