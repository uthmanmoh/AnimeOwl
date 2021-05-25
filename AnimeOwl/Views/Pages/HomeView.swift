//
//  HomeView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: AnimeModel
    
    @Binding var sideBarOpened: Bool
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        if model.animes != nil {
            ZStack {
                BackgroundColour()
                ScrollView(showsIndicators: false) {
                    LazyVGrid (columns: gridItems) {
                        ForEach(model.animes!.top) { anime in
                            AnimeCard(anime: anime)
                                .padding(.horizontal, 3)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("Top Anime") ////////////////////// TEMPORARY
        } else {
            ProgressView()
        }
    }
}

//struct TopAnimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
