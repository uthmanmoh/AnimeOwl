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
    
    @State private var isDetailShowing: Bool = false
    
    //    private var scoreBasedColour: Color {
    //
    //        let ratio = 25.5/255
    //        return Color(.sRGB, red: anime.score * ratio, green: anime.score / ratio, blue: 0, opacity: 0.4)
    //
    //    }
    
    var body: some View {
        VStack {
            let uiImage = UIImage(data: anime.imageData ?? Data())
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .aspectRatio(0.6466, contentMode: .fit)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .shadow(color: .black, radius: 15, x: 5, y: 5)
                .onTapGesture {
                    isDetailShowing = true
                }
                .sheet(isPresented: $isDetailShowing, onDismiss: {
                    model.resetDetailAnime()
                }) {
                    AnimeDetailView()
                        .onAppear {
                            model.getDetailAnime(id: anime.id)
                        }
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
