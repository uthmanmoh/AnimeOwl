//
//  AnimeList.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct AnimeList: View {
    @EnvironmentObject var model: AnimeModel
    
    var animes: [Anime]
    
    // 2 grid items
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid (columns: gridItems) {
                ForEach(animes) { anime in
                    AnimeCard(anime: anime)
                        .padding(.horizontal, 3)
                }
            }
            .padding(.horizontal)
        }
    }
}

//struct AnimeList_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeList()
//    }
//}
