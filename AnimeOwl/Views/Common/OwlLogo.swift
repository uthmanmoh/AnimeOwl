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
                .frame(width: 150, height: 150)
                .foregroundColor(Color("button"))
                .shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 10)
                .blur(radius: 2)
            Text("🦉")
                .font(.system(size: 75))
        }
    }
}

struct OwlLogo_Previews: PreviewProvider {
    static var previews: some View {
        OwlLogo()
            
    }
}
