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
            
            ZStack (alignment: .top) {
                BackgroundColour()
                
                let uiImage = UIImage(data: anime.imageData ?? Data())
                VStack {
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .shadow(color: .black, radius: 20, y: 10)
                        .opacity(0.8)
                        .padding(.top, -10)
                        .overlay(
                            // Anime Title
                            Text(anime.title)
                                .font(Font.custom("Avenir Heavy", size: 30))
                                .padding()
                                .background(Color("button").blur(radius: 3.0).opacity(0.9).blendMode(.overlay))
                                .cornerRadius(25.0)
                                .shadow(color: .black, radius: 10)
                                .padding(.bottom, 3)
                                .padding(.horizontal, 30)
                            , alignment: .bottom)
                    
                    
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Rated: ")
                                .bold()
                                .frame(maxWidth: 100, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            Text("#\(anime.rank)")
                        }
                        .padding(5)
                        
                        HStack (alignment: .top) {
                            Text("Episodes: ")
                                .bold()
                                .frame(maxWidth: 100, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            Text("\(anime.episodes)")
                        }
                        .padding(5)
                        
                        HStack (alignment: .top) {
                            Text("Description: ")
                                .bold()
                                .frame(maxWidth: 100, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            Text(anime.synopsis)
                                .lineLimit(4)
                        }
                        .padding(5)
                        
                        Spacer()
                        
                        // Follow Button
                        ZStack {
                            Circle()
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .frame(width: 80, height: 80)
                                .shadow(color: Color(.label), radius: model.isFollowingAnime ? 0 : 10)
                                .animation(.default)
                            Button(action: {
                                model.isFollowingAnime.toggle()
                                
                                model.updateFollowing(forAnime: anime)
                            }) {
                                
                                VStack {
                                    Image(systemName: model.isFollowingAnime ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color(.systemYellow))
                                    Text("Follow")
                                        .font(.caption)
                                        .padding(.top, -8)
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                            
                        }
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .ignoresSafeArea()
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
