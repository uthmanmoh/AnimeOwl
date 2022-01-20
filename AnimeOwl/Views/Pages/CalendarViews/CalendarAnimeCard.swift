//
//  CalendarAnimeCard.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-06-01.
//

import SwiftUI

struct CalendarAnimeCard: View {
    @ObservedObject var anime: DetailAnime
    
    var body: some View {
        VStack {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: anime.images?.jpg.imageUrl ?? "")) { i in
                    i.image?.resizable() ?? Image("").resizable()
                }
                .aspectRatio(0.6466, contentMode: .fit)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .shadow(color: .black, radius: 15, x: 5, y: 5)
            } else {
                // Fallback on earlier versions
            }
            
            Text(anime.title )
                .bold()
            Text("\(anime.score ?? 0, specifier: "%.2f") ⭐️")
            if let date = anime.broadcast?.time {
                Text(date)
            }
        }
        .frame(height: 265)
        .padding(.horizontal, 3)
    }
}

//struct CalendarAnimeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarAnimeCard()
//    }
//}
