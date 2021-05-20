//
//  ListView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import SwiftUI
import FirebaseAuth

struct ListView: View {
    
    @Binding var loggedIn: Bool
    @EnvironmentObject var model: AnimeModel
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            if model.animes != nil {
                ScrollView(showsIndicators: false) {
                    LazyVGrid (columns: gridItems) {
                        ForEach(model.animes!.top) { anime in
                            AnimeCard(anime: anime)
                        }
                    }
                    
                }
                .padding()
                .navigationBarTitle("Top Anime")
                .navigationBarItems(trailing: Button("Sign Out") {
                    try? Auth.auth().signOut()
                    loggedIn = false
                })
            } else {
                ProgressView()
            }
        }
        
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(loggedIn: Binding.constant(true))
//    }
//}
