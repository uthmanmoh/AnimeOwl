//
//  LaunchView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseUI

struct LaunchView: View {
    
    @State private var loggedIn = false
    @State private var loginFormShowing = false
    
    var body: some View {
        if !loggedIn {
            Button(action: {
                loginFormShowing = true
            }) {
                Text("Sign In")
            }
            .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                LoginForm()
            }
            .onAppear {
                checkLogin()
            }
        } else { // loggedIn == true
            ContentView(loggedIn: $loggedIn)
        }
    }
    
    func checkLogin() {
        self.loggedIn = FUIAuth.defaultAuthUI()?.auth?.currentUser == nil ? false: true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
