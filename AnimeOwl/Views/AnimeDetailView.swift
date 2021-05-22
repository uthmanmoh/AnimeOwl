//
//  AnimeDetailView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import SwiftUI

struct AnimeDetailView: View {
    var anime: Result
    
    var body: some View {
        ZStack {
            BackgroundColour()
            let uiImage = UIImage(data: anime.imageData ?? Data())
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY)
                .opacity(0.4)
                .blur(radius: 10)
            VStack {
                Text(anime.title)
                    .bold()
                    .font(.system(size: 34))
                    .padding(.top, 75)
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("This anime is rated #\(anime.rank) on MyAnimeList with \(anime.score, specifier: "%.2f") stars")
                    Text("It has \(anime.episodes) episodes starting from \(anime.startDate ?? "*Unknown*") to \(anime.endDate ?? "*Unknown*")")
                }
                .padding(.top)
                .font(.system(size: 20, weight: .medium))
                
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}
//
//struct AnimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeDetailView(anime: )
//    }
//}
