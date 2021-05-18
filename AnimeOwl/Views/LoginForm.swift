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
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.init(.sRGB, white: 0.1, opacity: 0.7))
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        formShowing = false
                    }) {
                        Image(systemName: "xmark")
                    }
                    .padding(.trailing)
                    .padding(.top, -30)
                }
                
                Text("Sign In")
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size: 33))
                    .foregroundColor(.white)
                
                
                OwlLogo()
                    .padding(.bottom, 50)
                // MARK: - Login info
                VStack {
                    TextField("Email", text: $email)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    SecureField("Password", text: $password)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                
                // MARK: - Error Message
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                    }
                }
                
                
                // MARK: - Sign In Button
                Button(action: {
                    signIn()
                }) {
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 50)
                                .foregroundColor(Color(.brown))
                                .padding()
                            Text("Sign In")
                                .font(Font.custom("Avenir Heavy", size: 17))
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.top, 50)
        }
        
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
        LoginForm(formShowing: Binding.constant(true))
    }
}
