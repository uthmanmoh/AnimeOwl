//
//  FollowingView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct FollowingView: View {
    @EnvironmentObject var model: AnimeModel
    
    var body: some View {
        ZStack {
            BackgroundColour()
            AnimeList(animes: model.followingAnimes)
        }
        .onAppear {
            model.setFollowingAnimes()
        }
    }
}

//struct FollowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingView()
//    }
//}
