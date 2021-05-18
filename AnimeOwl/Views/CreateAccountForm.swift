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
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    TextField("Name", text: $name)
                    SecureField("Password", text: $password)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                    }
                }
                
                Button(action: {
                    createAccount()
                }) {
                    HStack {
                        Spacer()
                        Text("Create Account")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Create an Account")
            .navigationBarItems(trailing: Button(action: {
                formShowing = false
            }) {
                Image(systemName: "xmark")
            })
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
