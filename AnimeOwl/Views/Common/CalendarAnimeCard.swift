//
//  CalendarAnimeCard.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-06-01.
//

import SwiftUI

struct CalendarAnimeCard: View {
    @ObservedObject var anime: DayAnime
    
    var body: some View {
        VStack {
            if let imageData = anime.imageData {
                let uiImage = UIImage(data: imageData)
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .aspectRatio(0.6466, contentMode: .fit)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: .black, radius: 15, x: 5, y: 5)
            } else {
                ProgressView()
                    .aspectRatio(0.6466, contentMode: .fit)
                    .frame(height: 180)
            }
            
            Text(anime.title ?? "")
                .bold()
            Text("\(anime.score ?? 0, specifier: "%.2f") ⭐️")
            if let date = anime.airTime {
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
