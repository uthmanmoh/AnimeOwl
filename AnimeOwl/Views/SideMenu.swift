//
//  SideMenu.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-21.
//

import SwiftUI
import FirebaseAuth

struct SideMenu: View {
    @EnvironmentObject var model: AnimeModel
    
    let width: CGFloat
    @Binding var sideMenuOpened: Bool
    
    @Binding var currentView: SideMenuOptions
    
    @State private var logOutPressed = false
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color("button")
                .ignoresSafeArea()
            
            //            Button(action :{
            //                withAnimation(.spring()) {
            //                    sideMenuOpened.toggle()
            //                }
            //            }) {
            //                Image(systemName: "xmark")
            //                    .resizable()
            //                    .frame(width: 20, height: 20)
            //            }
            //            .accentColor(Color(.brown))
            //            .padding()
            //            .padding(.top, 60)
            
            
            ScrollView {
                VStack (alignment: .leading) {
                    
                    Text(model.user.username)
                        .font(Font.custom("Avenir Heavy", size: 30))
                        .padding()
                        .border(Color(.label), width: 3)
                        .padding([.top, .leading], 40)
                    
                    Divider()
                        .padding(.trailing)
                    
                    ForEach(SideMenuOptions.allCases.dropLast(), id: \.self) { option in
                        SideMenuOptionView(option: option, isCurrent: currentView == option)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    sideMenuOpened = false
                                }
                                    self.currentView = option
                            }
                        
                        Divider()
                            .padding(.trailing)
                    }
                    
                    Button(action: {
                        self.logOutPressed = true
                    }) {
                        SideMenuOptionView(option: .logOut)
                    }
                    .alert(isPresented: $logOutPressed) {
                        Alert(title: Text("Are you sure you want to log out?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Log out"), action: {
                            model.saveUserData()
                            try? Auth.auth().signOut()
                            withAnimation(.default) {
                                model.checkLogin()
                            }
                        }))
                    }
                    
                }
            }
            .padding()
        }
        .frame(width: width)
        .padding(.leading, -(UIScreen.main.bounds.width - width))
    }
}


//struct SideMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenu(width: UIScreen.main.bounds.width, sideMenuOpened: .constant(true))
//    }
//}
