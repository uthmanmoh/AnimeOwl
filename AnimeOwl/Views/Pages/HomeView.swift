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
        ZStack {
            BackgroundColour()
            AnimeList(animes: model.topAnimes.data)
        }
        .navigationBarTitle("Top Anime") ////////////////////// TEMPORARY
        
    }
}

//struct TopAnimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
