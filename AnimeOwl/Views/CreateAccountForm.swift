//
//  CreateAccountForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountForm: View {
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var name = ""
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
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.trailing)
                    .padding(.top, -30)
                }
                
                Text("Create an Account")
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size: 33))
                    .foregroundColor(Color(.lightText))
                
                
                OwlLogo()
                    .padding(.bottom, 50)
                // MARK: - Account info
                VStack {
                    TextField("Email", text: $email)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    TextField("Name", text: $name)
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
                    createAccount()
                }) {
                    HomeButton(text: "Create Account")
                }
                .padding(.top)
                Spacer()
            }
            .padding(.top, 50)
        }
        
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
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

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(formShowing: Binding.constant(true))
    }
}
