//
//  SideMenu.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-21.
//

import SwiftUI
import FirebaseAuth

struct SideMenu: View {
    @EnvironmentObject var userModel: UserModel
    
    let width: CGFloat
    @Binding var sideBarOpened: Bool
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color("button")
                .ignoresSafeArea()
            
            Button(action :{
                withAnimation(.spring()) {
                    sideBarOpened.toggle()
                }
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .accentColor(Color(.brown))
            .padding()
            .padding(.top, 60)
        
            HStack {
                
                VStack (alignment: .leading, spacing: 30) {
                    
                    Text(userModel.user.username)
                        .font(Font.custom("Avenir Heavy", size: 30))
                        .padding()
                        .border(Color(.label), width: 3)
                        .padding(.leading, 40)
                    
                    Group {
                        HStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        Divider()
                    }
                    HStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    Divider()
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    Divider()
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Following")
                    }
                    Divider()
                    Group {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Calendar")
                        }
                        Divider()
                    }
                    Group {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        Divider()
                        Button("Log Out") {
                            userModel.saveData()
                            try? Auth.auth().signOut()
                            userModel.checkLogin()
                        }
                        .accentColor(Color(.brown))
                        .font(.system(.headline))
                    }
                }
                
                Spacer()
            }
            .padding()
            .padding(.top, 100)
            .font(.system(size: 20))
            
            Spacer()
        }
        .animation(.default)
    }
}


struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(width: UIScreen.main.bounds.width, sideBarOpened: .constant(true))
    }
}
