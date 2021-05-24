//
//  LoginForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    @EnvironmentObject var userModel: UserModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        if !userModel.loggedIn {
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
                                .brightness(email == "" ? 0.3 : 0)
                                .padding(12)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(15)
                                .keyboardType(.emailAddress)
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                                .brightness(password == "" ? 0.3 : 0)
                                .padding(12)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(15)
                        }
                        .padding(.top, 35)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        
                        // MARK: - Error Message
                        ErrorMessage(errorMessage: $errorMessage)
                        
                        // MARK: - Login Button
                        Button(action: {
                            signIn()
                        }) {
                            HomeButton(text: "Login")
                        }
                        
                        // MARK: - Create Account
                        NavigationLink(
                            destination: CreateAccountForm(),
                            label: {
                                HomeButton(text: "Sign Up")
                                    .padding(.vertical)
                            })
                        
                        Button("Continue as Guest") {
                            // Guest login
                            userModel.checkLogin()
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 50)
                }
                .ignoresSafeArea()
                .navigationBarTitle("Login")
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(Color(.brown))
            .onAppear {
                resetInfo()
            }
        } else {
            HomeView()
                .environmentObject(AnimeModel())
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    errorMessage = error!.localizedDescription
                    return
                }
                
                userModel.checkLogin()
                
                userModel.getUserData()
            }
        }
    }
    
    func resetInfo() {
        email = ""
        password = ""
        errorMessage = ""
        userModel.checkLogin()
    }
    
}

//struct LoginForm_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LoginForm()
//            LoginForm()
//                .preferredColorScheme(.dark)
//        }
//    }
//}
