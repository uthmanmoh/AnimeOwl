//
//  LoginForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import Foundation
import SwiftUI
import FirebaseUI

struct LoginForm: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {
            return UINavigationController()
        }
        
        let providers = [FUIEmailAuth()]
        authUI!.providers = providers
        
        return authUI!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
}
