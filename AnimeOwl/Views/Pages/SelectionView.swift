//
//  SelectionView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var model: AnimeModel
    @State private var sideMenuOpened = false
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        ZStack {
            if sideMenuOpened {
                SideMenu(width: 300, sideMenuOpened: $sideMenuOpened)
            }
            
            NavigationView {
                Group {
                    switch model.currentView {
                    case .home:
                        HomeView(sideMenuOpened: $sideMenuOpened)
                    case .following:
                        FollowingView()
                    case .calendar:
                        CalendarView()
                    case .search:
                        SearchView()
                    case .profile:
                        ProfileView()
                    case .settings:
                        SettingsView()
                    case .logOut:
                        EmptyView()
                    }
                }
                .navigationBarTitle(model.currentView.title)
                .navigationBarItems(leading:
                                        Button(action: {
                                            withAnimation(.spring()){
                                                sideMenuOpened = true
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
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(Color(.brown))
            .offset(x: sideMenuOpened ? 300 : 0)
            .blur(radius: sideMenuOpened ? 3 : 0)
            .shadow(radius: sideMenuOpened ? 15 : 0)
            .overlay(
                Rectangle()
                    .foregroundColor(Color(.black).opacity(0.01))
                    .animation(.none)
                    .frame(maxWidth: sideMenuOpened ? .infinity : 0, maxHeight: sideMenuOpened ? .infinity : 0)
                    .offset(x: sideMenuOpened ? 300 : 0)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            sideMenuOpened = false
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                if value.translation != CGSize.zero {
                                    withAnimation(.spring()) {
                                        sideMenuOpened = false
                                    }
                                }
                            }
                            
                            .onEnded({ _ in
                                withAnimation(.spring()) {
                                    sideMenuOpened = false
                                }
                            })
                    )
            )
            .onAppear {
                model.getTopAnime()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                model.saveUserData()
            })
            
        }
        .ignoresSafeArea()
        
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectionView()
//    }
//}
