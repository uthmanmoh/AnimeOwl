//
//  AnimeCard.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-20.
//

import SwiftUI

struct AnimeCard: View {
    @ObservedObject var anime: Anime
    @EnvironmentObject var model: AnimeModel
    
    private var scoreBasedColour: Color {
        
        if anime.score >= 9 {
            return Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        }
        else if anime.score >= 8 {
            return Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        }
        else if anime.score >= 7 {
            return Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        }
        else if anime.score >= 6 {
            return Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        }
        else {
            return Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
        
    }
    
    var body: some View {
        VStack {
            let uiImage = UIImage(data: anime.imageData ?? Data())
            NavigationLink(destination: AnimeDetailView()
                            .onAppear {
                                model.getDetailAnime(id: anime.id)
                            }) {
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .aspectRatio(0.6466, contentMode: .fit)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: scoreBasedColour, radius: 12)
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
