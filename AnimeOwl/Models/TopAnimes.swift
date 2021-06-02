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
    var top: [Anime]
}

class Anime: Decodable, Identifiable, ObservableObject {
    
    @Published var imageData: Data?
    
    var id: Int
    var url: String
    var imageUrl: String?
    var title: String
    var type: String
    var score: Double
    var startDate: String?
    var endDate: String?
    var members: Int
    var rank: Int
    var episodes: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id = "mal_id"
        case url
        case imageUrl = "image_url"
        case title
        case type
        case score
        case startDate = "start_date"
        case endDate = "end_date"
        case members
        case rank
        case episodes
        
    }
    
    init(id: Int, url: String, imageUrl: String? = nil, title: String, type: String, score: Double,
         startDate: String? = nil, endDate: String? = nil, members: Int, rank: Int, episodes: Int) {
        self.id = id
        self.url = url
        self.imageUrl = imageUrl
        self.title = title
        self.type = type
        self.score = score
        self.startDate = startDate
        self.endDate = endDate
        self.members = members
        self.rank = rank
        self.episodes = episodes
        
        getImageData()
    }
    
    func getImageData() {
        guard imageUrl != nil else { return }
        
        if let url = URL(string: imageUrl!) {
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if error == nil, let data = data {
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                } else {
                    print(error?.localizedDescription ?? "Error getting image data")
                }
            }.resume()
        }
    }
}
