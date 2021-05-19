//
//  LaunchView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @State private var loggedIn = false
    @State private var loginFormShowing = false
    @State private var createFormShowing = false
    
    var body: some View {
        if !loggedIn {
            
            ZStack {
                Color.white
                LinearGradient(gradient: Gradient(colors: [Color("button").opacity(0.8), Color("background").opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack (spacing: 20) {
                    
                    Spacer()
                    VStack {
                        Text("Welcome to")
                            .font(Font.custom("Avenir Heavy", size: 30))
                        Text("AnimeOwl")
                            .font(Font.custom("Avenir Heavy", size: 55))
                    }
                    .opacity(0.8)
                    OwlLogo()
                        .padding(.bottom, 80)
                    
                    Button(action: {
                        loginFormShowing = true
                    }) {
                        HomeButton(text: "Sign In")
                    }
                    .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                        LoginForm(formShowing: $loginFormShowing)
                    }
                    
                    Button(action: {
                        createFormShowing = true
                    }) {
                        HomeButton(text: "Create Account")
                    }
                    .sheet(isPresented: $createFormShowing, onDismiss: checkLogin) {
                        CreateAccountForm(formShowing: $createFormShowing)
                    }
                    Spacer()
                    
                }
                .onAppear {
                    checkLogin()
                }
            }
            .ignoresSafeArea()
            
            
        } else { // loggedIn == true
            ContentView(loggedIn: $loggedIn)
        }
    }
    
    func checkLogin() {
        self.loggedIn = Auth.auth().currentUser == nil ? false: true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchView()
            LaunchView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
            
            
    }
}
