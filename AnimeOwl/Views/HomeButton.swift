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
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.brown))
                .frame(width: 300, height: 50)
            Text(text)
                .font(Font.custom("Avenir Heavy", size: 17))
                .foregroundColor(.white)
        }
        .shadow(radius: 7)
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton(text: "Create Account")
    }
}
