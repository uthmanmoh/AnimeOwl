//
//  AnimeCard.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct AnimeCard: View {
    @ObservedObject var anime: Result
    
    var body: some View {
        VStack {
            let uiImage = UIImage(data: anime.imageData ?? Data())
            NavigationLink(destination: AnimeDetailView(anime: anime)) {
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .aspectRatio(0.6466, contentMode: .fit)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: Color(.label), radius: 10)
            }
            Text(anime.title)
                .bold()
            Text("\(anime.score, specifier: "%.2f")")
        }
        .frame(height: 250)
    }
}

//struct AnimeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeCard()
//    }
//}
