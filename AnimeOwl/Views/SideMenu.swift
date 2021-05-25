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
    @Binding var sideBarOpened: Bool
    
    @Binding var currentView: SideMenuOptions
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color("button")
                .ignoresSafeArea()
            
            //            Button(action :{
            //                withAnimation(.spring()) {
            //                    sideBarOpened.toggle()
            //                }
            //            }) {
            //                Image(systemName: "xmark")
            //                    .resizable()
            //                    .frame(width: 20, height: 20)
            //            }
            //            .accentColor(Color(.brown))
            //            .padding()
            //            .padding(.top, 60)
            
            
            VStack {
                
                Text(model.user.username)
                    .font(Font.custom("Avenir Heavy", size: 30))
                    .padding()
                    .border(Color(.label), width: 3)
                    .padding([.leading, .top], 40)
                
                ForEach(SideMenuOptions.allCases, id: \.self) { option in
                    SideMenuOptionView(option: option)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                sideBarOpened = false
                            }
                                self.currentView = option
                        }
                    Divider()
                }
                
                                        Button("Log Out") {
                                            model.saveUserData()
                                            try? Auth.auth().signOut()
                                            model.checkLogin()
                                        }
                
                Spacer()
            }
            .padding()
        }
        .animation(.default)
    }
}


//struct SideMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenu(width: UIScreen.main.bounds.width, sideBarOpened: .constant(true))
//    }
//}
