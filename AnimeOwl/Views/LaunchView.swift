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
                        .bold()
                        .font(Font.custom("Avenir Heavy", size: 33))
                        .foregroundColor(Color(.lightText))
                    ZStack {
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color(.brown))
                            .shadow(radius: 10)
                        Text("🦉")
                            .font(Font.custom("Avenir", size: 100))
                    }
                    .padding(.bottom, 80)
                    
                    Button(action: {
                        loginFormShowing = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.brown))
                                .frame(width: 300, height: 50)
                            Text("Sign In")
                                .font(Font.custom("Avenir Heavy", size: 17))
                                .foregroundColor(.white)
                        }
                        .shadow(radius: 7)
                    }
                    .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                        LoginForm(formShowing: $loginFormShowing)
                    }
                    
                    Button(action: {
                        createFormShowing = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.brown))
                                .frame(width: 300, height: 50)
                            Text("Create Account")
                                .font(Font.custom("Avenir Heavy", size: 17))
                                .foregroundColor(.white)
                        }
                        .shadow(radius: 7)
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
