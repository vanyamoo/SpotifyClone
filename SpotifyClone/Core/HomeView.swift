//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 08/10/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct HomeView: View {
    
    @Environment(\.router) var router
    
    @State private var currentUser: User?
    @State private var selectedCategory: Category?
    @State private var products: [Product] = []
    @State private var recentlyViewed: [Product]?
    @State private var productRows: [ProductRow] = []
    
    
    @ViewBuilder
    private var recentsSection: some View {
        if let items = recentlyViewed {
            RecentsGrid(items: items) { item in
                RecentlyViewedCell(title: item.title, imageName: item.firstImage)
                    .asButton(.press) {
                        goToPlaylistView(product: item)
                    }
            }
        }
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product)
        }
    }
    
    @ViewBuilder
    private var newReleaseSection: some View {
        if let product = recentlyViewed?.first {
            NewReleaseCell(
                imageName: product.firstImage,
                headline: product.title,
                subheadline: product.description,
                title: product.title,
                subtitle: product.description) {
                    print("onAddToPlaylistPressed")
                } onPlayPressed: {
                    goToPlaylistView(product: product)
                }
        }
    }
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack {
                Text(row.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(imageName: product.firstImage, productTitle: product.title, imageSize: 120)
                                .asButton(.press) {
                                    goToPlaylistView(product: product)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders], content: {

                    Section(content: {
                        VStack(spacing:16) {
                            recentsSection
                                .padding(.horizontal)
                            newReleaseSection
                                .padding(.horizontal)
                            listRows
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
        guard products.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await DatabaseHelper().getProducts()
            //if products.count >= 8 {
                recentlyViewed = Array(products.prefix(upTo: 8))
            //}
            print(products.count)
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand ?? "Brand goes here"})) // Set so we
            for brand in allBrands {
                //let products = products.filter({ $0.brand == brand })
                rows.append(ProductRow(title: brand, products: products))
            }
            productRows = rows
        } catch {
            print(error.localizedDescription)
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
    RouterView { _ in
        HomeView()
    }
}
