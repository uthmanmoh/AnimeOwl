//
//  CreateAccountForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CreateAccountForm: View {
    @EnvironmentObject var userModel: UserModel
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var secondPassword = ""
    
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            BackgroundColour()
            VStack {
                Spacer()
                
                OwlLogo()
                    .padding(.bottom, 50)
                    .padding(.top, -20)
                
                // MARK: - Account info
                VStack (alignment: .leading) {
                    Text("Create an Account")
                        .font(Font.custom("Avenir Heavy", size: 25))
                        .padding(.leading, 8)
                    TextField("Email", text: $email)
                        .foregroundColor(.black)
                        .brightness(email == "" ? 0.3 : 0)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .keyboardType(.emailAddress)
                    TextField("Username", text: $username)
                        .foregroundColor(.black)
                        .brightness(username == "" ? 0.3 : 0)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .brightness(password == "" ? 0.3 : 0)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    SecureField("Re-Enter Password", text: $secondPassword)
                        .foregroundColor(.black)
                        .brightness(secondPassword == "" ? 0.3 : 0)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                // MARK: - Error Message
                ErrorMessage(errorMessage: $errorMessage)
                
                // MARK: - Sign In Button
                Button(action: {
                    createAccount()
                }) {
                    HomeButton(text: "Create Account")
                }
                Spacer()
            }
        }
        .onAppear {
            resetInfo()
        }
        .ignoresSafeArea()
        
    }
    
    func createAccount() {
        if secondPassword != password {
            errorMessage = "Passwords do not match"
            return
        }
        
        if username == "" {
            errorMessage = "Please fill out all details"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    errorMessage = error!.localizedDescription
                    return
                }
                
                let user = Auth.auth().currentUser
                let db = Firestore.firestore()
                let reference = db.collection("users").document(user!.uid)
                
                reference.setData(["username": username], merge: true)
                
                let currentUser = userModel.user
                currentUser.username = username
                
                userModel.checkLogin()
            }
        }
    }
    
    func resetInfo() {
        email = ""
        username = ""
        password = ""
        secondPassword = ""
        errorMessage = ""
    }
    
}
//
//struct CreateAccountForm_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAccountForm()
//    }
//}
