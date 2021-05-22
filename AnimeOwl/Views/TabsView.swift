//
//  TabsView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import SwiftUI
import FirebaseAuth

struct TabsView: View {
    
    @State private var tabSelected = 1
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        TabView (selection: $tabSelected) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            Text("Calendar View here")
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
            
            Text("Search View here")
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
        }
        .accentColor(Color(.label))
    }
    
}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(loggedIn: Binding.constant(true))
//    }
//}
