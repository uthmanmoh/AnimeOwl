//
//  LoginForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    @State private var loggedIn = false
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        if !loggedIn {
            
            NavigationView {
                ZStack {
                    BackgroundColour()
                    VStack {
                        VStack {
                            Text("AnimeOwl")
                                .font(Font.custom("Avenir Heavy", size: 55))
                        }
                        .offset(y: 30)
                        .opacity(0.8)
                        
                        OwlLogo()
                        
                        // MARK: - Login info
                        VStack (alignment: .leading) {
                            Text("Login")
                                .font(Font.custom("Avenir Heavy", size: 25))
                                .padding(.leading, 8)
                            TextField("Email", text: $email)
                                .foregroundColor(.black)
                                .brightness(0.3)
                                .padding(12)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(15)
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                                .brightness(0.3)
                                .padding(12)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(15)
                        }
                        .padding(.top, 35)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        
                        // MARK: - Error Message
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 50)
                            
                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .bold()
                                    .font(.system(size: 13))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Login Button
                        Button(action: {
                            signIn()
                        }) {
                            HomeButton(text: "Login")
                        }
                        
                        // MARK: - Create Account
                        NavigationLink(
                            destination: CreateAccountForm(loggedIn: $loggedIn),
                            label: {
                                HomeButton(text: "Sign Up")
                                    .padding(.vertical)
                            })
                        
                        Button("Continue as Guest") {
                            // Guest login
                            loggedIn = true
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 50)
                }
                .ignoresSafeArea()
                .navigationBarTitle("Home")
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(Color(.brown))
            .onAppear {
                // Reset info
                email = ""
                password = ""
                errorMessage = ""
                checkLogin()
            }
        } else {
            TabsView(loggedIn: $loggedIn)
                .environmentObject(AnimeModel())
        }
        
    }
    
    func checkLogin() {
        self.loggedIn = Auth.auth().currentUser == nil ? false: true
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    loggedIn = true
                }
            }
        }
    }
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginForm()
            LoginForm()
                .preferredColorScheme(.dark)
        }
    }
}
