//
//  AnimeDetailView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import SwiftUI

struct AnimeDetailView: View {
    @ObservedObject var anime: Result
    
    var body: some View {
        VStack {
            Text(anime.title)
                .bold()
                .font(.system(size: 30))
                .padding()
            Spacer()
        }
    }
}
//
//struct AnimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeDetailView(anime: )
//    }
//}
