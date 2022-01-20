////
////  Anime.swift
////  AnimeOwl
////
////  Created by Uthman Mohamed on 2021-05-06.
////
//
//import Foundation
//
//struct Animes: Decodable {
//    var data = [Anime]()
//}
//
//class Anime: Decodable, Identifiable {
//
//    var id: UUID?
//    var title: String
//    var type: String
//    var episodes: Int
//    var status: String
//    var animeSeason: AnimeSeason
//    var picture: String // URL
//    var thumbnail: String // URL
//    var synonyms: [String]
//    var relations: [String] // URL
//    var tags: [String]
//
//}
//
//struct AnimeSeason: Decodable {
//
//    var season: String
//    var year: Int?
//
//}
//
//

import Foundation

struct TopAnimes: Decodable {
    var data: [Anime]
}

class Anime: Decodable, Identifiable, ObservableObject {

    var id: Int
    var url: String
    var images: Images?
    var title: String
    var type: String
    var score: Double?
    var members: Int
    var rank: Int?
    var episodes: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "mal_id"
        case url
        case images
        case title
        case type
        case score
        case members
        case rank
        case episodes
        
    }
    
    init(id: Int, url: String, images: Images?, title: String, type: String, score: Double?,
         members: Int, rank: Int?, episodes: Int?) {
        self.id = id
        self.url = url
        self.images = images
        self.title = title
        self.type = type
        self.score = score
        self.members = members
        self.rank = rank
        self.episodes = episodes
    }
}

struct Images: Decodable {
    var jpg: ImageSizes
}

struct ImageSizes: Decodable {
    var imageUrl: String
    var smallImgUrl: String
    var largeImgUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case smallImgUrl = "small_image_url"
        case largeImgUrl = "large_image_url"
    }
}
