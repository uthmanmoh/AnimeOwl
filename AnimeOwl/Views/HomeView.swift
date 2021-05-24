//
//  HomeView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var model: AnimeModel
    @State private var sideBarOpened = false
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        ZStack {
            if sideBarOpened {
                SideMenu(width: 300, sideBarOpened: $sideBarOpened)
            }
            
            NavigationView {
                if model.animes != nil {
                    ZStack {
                        BackgroundColour()
                            .ignoresSafeArea()
                        ScrollView(showsIndicators: false) {
                            LazyVGrid (columns: gridItems) {
                                ForEach(model.animes!.top) { anime in
                                    AnimeCard(anime: anime)
                                        .padding(.horizontal, 3)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .navigationBarTitle("Top Anime")
                    .navigationBarItems(leading:
                        Button(action: {
                            withAnimation(.spring()){
                                sideBarOpened.toggle()
                            }
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
                    )
                } else {
                    ProgressView()
                }
            }
            .accentColor(Color(.brown))
            .offset(x: sideBarOpened ? 300 : 0)
            .blur(radius: sideBarOpened ? 3 : 0)
            .shadow(radius: sideBarOpened ? 15 : 0)
            .overlay(
                Rectangle()
                    .foregroundColor(sideBarOpened ? Color("button").opacity(0.01) : .clear)
                    .offset(x: sideBarOpened ? 300 : 0)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            sideBarOpened.toggle()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                if value.translation != CGSize.zero {
                                    withAnimation(.spring()) {
                                        sideBarOpened.toggle()
                                    }
                                }
                            }
                            
                            .onEnded({ _ in
                                withAnimation(.spring()) {
                                    sideBarOpened.toggle()
                                }
                            })
                    )
            )
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                userModel.saveData()
            })
        }
        .ignoresSafeArea()
        
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
