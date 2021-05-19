//
//  HomeButton.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI

struct HomeButton: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Color("button").opacity(0.6)
                .frame(width: 300, height: 50)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 15)
                .blur(radius: 1)
            Text(text)
                .foregroundColor(Color(.label))
                .font(Font.custom("Avenir", size: 17))
        }
        .shadow(radius: 7)
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton(text: "Create Account")
    }
}
