//
//  OwlLogo.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI

struct OwlLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(.brown))
                .shadow(radius: 10)
            Text("🦉")
                .font(Font.custom("Avenir", size: 100))
        }
    }
}

struct OwlLogo_Previews: PreviewProvider {
    static var previews: some View {
        OwlLogo()
    }
}
