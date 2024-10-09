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
            //Color.spotifyBlack.ignoresSafeArea()
            HStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            //
                        }
                }
                
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(Category.allCases, id: \.self) { category in
                            CategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        
                        }
                        
                    }
                }
            }
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
}

#Preview {
    HomeView()
}
