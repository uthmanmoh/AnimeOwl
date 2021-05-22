//
//  BackgroundColour.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct BackgroundColour: View {
    var body: some View {
        ZStack {
            Color.white
            LinearGradient(gradient: Gradient(colors: [Color("button").opacity(0.8), Color("background").opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

struct BackgroundColour_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColour()
    }
}
