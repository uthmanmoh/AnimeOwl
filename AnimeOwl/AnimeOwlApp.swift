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
    • figure out whats going on with kimetsu no yaiba
    • fix user login stuff
    • FollowingView() only goes into AnimeDetailView if there are at least 3 animes (could be something to do with grid items)
    • add loading animation with logo and replace ProgressView()
 
 */
