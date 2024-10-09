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
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            header
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            //products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            user
            categories
        }
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
