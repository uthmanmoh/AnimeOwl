//
//  AnimeDetailView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import SwiftUI

struct AnimeDetailView: View {
    @EnvironmentObject var model: AnimeModel
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        if let anime = model.detailAnime {
            ZStack {
                BackgroundColour()
                    .opacity(0.15)
                
                VStack {
                    HStack {
                        Spacer()
                        Text(anime.title)
                            .font(Font.custom("Avenir Heavy", size: 35))
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            model.isFollowingAnime.toggle()
                            
                            if model.isFollowingAnime {
                                model.followAnime(anime: anime)
                            } else {
                                model.unfollowAnime(anime: anime)
                            }
                        }) {
                            VStack (spacing: 0) {
                                Image(systemName: model.isFollowingAnime ? "star.fill" : "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(.systemYellow))
                                
                                Text("Follow")
                                    .font(.caption)
                            }
                        }
                        .padding(.trailing, 15)
                        .padding(.bottom, -50)
                    }
                    
                    ScrollView {
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("This anime is rated #\(anime.rank) on MyAnimeList with \(anime.score, specifier: "%.2f") stars")
                            Text("It has \(anime.episodes) episodes lasting \(anime.duration) long")
                            Text("Status: \(anime.status)")
                            Text("Rating: \(anime.rating)")
                            
                        }
                        .padding(.top)
                        .font(.system(size: 20, weight: .medium))
                    }
                    .frame(width: UIScreen.main.bounds.maxX-40, height: UIScreen.main.bounds.maxY-200)
                }
                .redacted(reason: isLoading ? .placeholder : [])
            }
            .background(Image(uiImage: UIImage(data: anime.imageData ?? Data()) ?? UIImage())
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .opacity(0.3)
                            .blur(radius: 2)
                            .redacted(reason: isLoading ? .placeholder : []))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                    self.isLoading = false
                }
            }
        }
        else {
            ZStack {
                BackgroundColour()
                ProgressView()
            }
        }
    }
}
//
//struct AnimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeDetailView(anime: )
//    }
//}
