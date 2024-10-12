//
//  NewReleaseCell.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 09/10/2024.
//

import SwiftUI

struct NewReleaseCell: View {
    
    var imageName = Constants.randomImage
    var headline: String? = "New release from"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some playlist"
    var subtitle: String? = "Single - title"
    var onAddToPlaylistPressed: (() -> Void)?  // we make it optional so that we don't have to pass a closure in our Previews
    var onPlayPressed: (() -> Void)?
    
    var body: some View {
        VStack {
            headlineView
            
            HStack {
                mainImage
                mainInfoAndButtons
            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
        }
        .foregroundStyle(.spotifyWhite)
    }
    
    private var headlineView: some View {
        HStack {
            headineImage
            headlineText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var headineImage: some View {
        ImageLoaderView(urlString: imageName)
            .background(.spotifyWhite).opacity(0.8)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
    
    private var headlineText: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let headline {
                Text(headline)
                    .foregroundStyle(.spotifyLightGray)
                    .font(.callout)
            }
            
            if let subheadline {
                Text(subheadline)
                    .lineLimit(1)
                    .font(.title2)
                    .fontWeight(.medium)
            }
        }
    }
    
    private var mainImage: some View {
        ImageLoaderView(urlString: imageName)
            .frame(width: 140, height: 140)
    }
    
    private var mainInfoAndButtons: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 2) {
                titleText
                subtitleText
            }
            .font(.callout)
            
            newReleaseButtons
        }
        .padding(.trailing)
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var titleText: some View {
        if let title {
            Text(title)
                .lineLimit(2)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    private var subtitleText: some View {
        if let subtitle {
            Text(subtitle)
                .lineLimit(2)
                .foregroundStyle(.spotifyLightGray)
        }
    }
    
    private var newReleaseButtons: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus.circle")
                .foregroundStyle(.spotifyLightGray)
                .font(.title3)
                .padding(6)
                .background(.black.opacity(0.001)) // it's still rendering and tappable but we can't see it
                .onTapGesture {
                    onAddToPlaylistPressed?()
                }
                .offset(x: -6)
                .frame(maxWidth: .infinity, alignment: .leading) // better than using Spacer()
            
            Image(systemName: "play.circle.fill")
                .foregroundStyle(.spotifyWhite)
                .font(.title)
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        NewReleaseCell()
            .padding()
    }
}
