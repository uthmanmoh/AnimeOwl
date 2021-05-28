//
//  HomeView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: AnimeModel
    
    @Binding var sideMenuOpened: Bool
    
    var body: some View {
        if model.topAnimes != nil {
            ZStack {
                BackgroundColour()
                AnimeList(animes: model.topAnimes!.top)
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
