//
//  AnimeOwlApp.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import Firebase

@main
struct AnimeOwlApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginForm()
                .environmentObject(AnimeModel())
        }
    }
}

/* TODO:
 
    • fix sidemenu logo shadow bug
    • add delay on AnimeDetailView fetching data so the previous DetailAnime doesnt show
        - https://www.youtube.com/watch?v=5yHXcnn0KFY
    • figure out whats going on with kimetsu no yaiba
    • fix user login stuff
    • FollowingView() only goes into AnimeDetailView if there are at least 3 animes (could be something to do with grid items)
    •
 
 */
