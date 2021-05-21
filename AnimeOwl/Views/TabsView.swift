//
//  TabsView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import SwiftUI
import FirebaseAuth

struct TabsView: View {
    
    @Binding var loggedIn: Bool
    @EnvironmentObject var model: AnimeModel
    
    @State private var tabSelected = 1
    
    var body: some View {
        TabView (selection: $tabSelected) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            ProgressView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
            
            ProgressView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
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
