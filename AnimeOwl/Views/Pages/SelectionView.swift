//
//  SelectionView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var model: AnimeModel
    @State private var sideBarOpened = false
    
    @State var currentView: SideMenuOptions = .home
    
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        ZStack {
            if sideBarOpened {
                SideMenu(width: 300, sideBarOpened: $sideBarOpened, currentView: $currentView)
            }
            
            NavigationView {
                Group {
                    if currentView == .home {
                        HomeView(sideBarOpened: $sideBarOpened)
                    }
                    else if currentView == .following {
                        FollowingView()
                    }
                    else if currentView == .calendar {
                        CalendarView()
                    }
                    else if currentView == .search {
                        SearchView()
                    }
                    else if currentView == .profile {
                        ProfileView()
                    }
                    else { // settings
                        SettingsView()
                    }
                }
                .navigationBarTitle(currentView.title)
                .navigationBarItems(leading:
                    Button(action: {
                        withAnimation(.spring()){
                            sideBarOpened = true
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
            .offset(x: sideBarOpened ? 300 : 0)
            .blur(radius: sideBarOpened ? 3 : 0)
            .shadow(radius: sideBarOpened ? 15 : 0)
            .overlay(
                Rectangle()
                    .foregroundColor(Color("button").opacity(0.01))
                    .frame(maxWidth: sideBarOpened ? .infinity : 0, maxHeight: sideBarOpened ? .infinity : 0)
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
