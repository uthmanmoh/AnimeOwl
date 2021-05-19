//
//  LoginForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            Color.white
            LinearGradient(gradient: Gradient(colors: [Color("button").opacity(0.8), Color("background").opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        formShowing = false
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("button"))
                    }
                    .padding(.trailing)
                    .padding(.top, -30)
                }
                
                Text("Sign In")
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size: 33))
                    .opacity(0.8)
                
                OwlLogo()
                    .padding(.bottom, 50)
                // MARK: - Login info
                VStack {
                    TextField("Email", text: $email)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    SecureField("Password", text: $password)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 70)
                    
                    // MARK: - Error Message
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Sign In Button
                Button(action: {
                    signIn()
                }) {
                    HomeButton(text: "Sign In")
                }
                .padding(.top)
                Spacer()
            }
            .padding(.top, 50)
        }
        .ignoresSafeArea()
        
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    formShowing = false
                }
            }
        }
    }
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginForm(formShowing: Binding.constant(true))
            LoginForm(formShowing: Binding.constant(true))
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
