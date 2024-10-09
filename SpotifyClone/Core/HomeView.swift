//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 08/10/2024.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {
    
    @State private var currentUser: User?
    @State private var selectedCategory: Category?
    
    @State private var recentlyViewed: [Product]?
    
    
    @ViewBuilder
    var recentsSection: some View {
        if let items = recentlyViewed {
            RecentsGrid(items: items) { item in
                RecentlyViewedCell(title: item.title, imageName: item.firstImage)
            }
        }
    }
    
    var newReleaseSection: some View {
        NewReleaseCell()
    }
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders], content: {

                    Section(content: {
                        VStack {
                            recentsSection
                            
                            newReleaseSection
                            
                            ForEach(0..<20) { _ in
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 200, height: 200)
                            }
                        }
                        
                        
                    }, header: { header })
                    
                })
                .padding(.top)
                
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            
            recentlyViewed = Array(products.prefix(upTo: 8))
        } catch {
            
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            user
            categories
        }
        .padding(.vertical)
        .padding(.leading)
        .background(.spotifyBlack)
    }
    
    private var user: some View {
        ZStack {
            if let currentUser {
                ImageLoaderView(urlString: currentUser.image)
                    .background(.spotifyWhite)
                    .clipShape(Circle())
                    .onTapGesture {
                        //
                    }
            }
        }
        .frame(width: 35, height: 35)
    }
    
    private var categories: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
}
