//
//  HomeView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: AnimeModel
    @State private var logoPressed = false
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        NavigationView {
            if model.animes != nil {
                ZStack {
                    BackgroundColour()
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        LazyVGrid (columns: gridItems) {
                            ForEach(model.animes!.top) { anime in
                                AnimeCard(anime: anime)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .navigationBarTitle("Top Anime")
                    .navigationBarItems(leading:
                        Button(action: {
                            logoPressed = true
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("button"))
                                    .frame(width: 45, height: 45)
                                    .shadow(color: .black.opacity(2) ,radius: 10)
                                    .blur(radius: 1)
                                Text("🦉")
                                    .font(.system(size: 27))
                            }
                        }
                        .sheet(isPresented: $logoPressed) {
                            Text("Profile/settings?")
                        }
                    )
                }
            } else {
                ProgressView()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
