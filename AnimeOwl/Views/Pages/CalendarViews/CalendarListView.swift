//
//  CalendarListView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-06-03.
//

import SwiftUI

struct CalendarListView: View {
    @EnvironmentObject var model: AnimeModel
    
    var animes: [DetailAnime]
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                LazyVGrid (columns: gridItems) {
                    ForEach(animes) { anime in
                        CalendarAnimeCard(anime: anime)
                    }
                }
                .padding(.horizontal)
        }
    }
}

//struct CalendarListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarListView()
//    }
//}
