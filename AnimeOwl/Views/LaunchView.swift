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
                Rectangle()
                    .foregroundColor(Color.init(.sRGB, white: 0.1, opacity: 0.7))
                    .ignoresSafeArea()
                VStack (spacing: 20) {
                    
                    Spacer()
                    Text("Welcome to AnimeOwl!")
                        .font(Font.custom("Avenir Heavy", size: 33))
                        .foregroundColor(Color(.lightText))
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
        LaunchView()
    }
}
