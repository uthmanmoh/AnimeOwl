//
//  ContentView.swift
//  Anime Reviews App
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @Binding var loggedIn: Bool
    //@EnvironmentObject var model: AnimeModel
    
    var body: some View {
        /*ScrollView {
            ForEach(model.animes.data.filter({ anime in
                var contains = false
                for synonym in anime.synonyms {
                    if synonym.contains("Attack on Titan") {
                        contains = true
                    }
                }
                return (anime.title.contains("Attack on Titan") || contains) && anime.type == "TV"
            })) { anime in
                Text(anime.title)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.leading)
            }
        }*/
        VStack {
            Text("Welcome!")
                .padding()
            Button(action: {
                try? Auth.auth().signOut()
                loggedIn = false
            }) {
                Text("Sign Out")
            }
        }
        
    }
}
