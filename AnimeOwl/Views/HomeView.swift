//
//  HomeView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: AnimeModel
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            if model.animes != nil {
                ZStack {
                    BackgroundColour()
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        LazyVGrid (columns: gridItems) {
                            ForEach(model.animes!.top) { anime in
                                AnimeCard(anime: anime)
                            }
                        }
                    }
                    .navigationBarTitle("Top Anime")
                    .navigationBarItems(trailing:
                        ZStack {
                            Circle()
                                .foregroundColor(Color("button"))
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                                .blur(radius: 1)
                            Text("🦉")
                                .font(.system(size: 30))
                        }
                    )
                }
            } else {
                ProgressView()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
