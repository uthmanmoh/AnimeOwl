//
//  DetailAnime.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import Foundation

class DetailAnime: Decodable, ObservableObject {
    
    @Published var imageData: Data?
    
    var id: Int
    var url: String
    var imageUrl: String?
    var trailerUrl: String?
    var title: String
    var titleEnglish: String?
    var titleJapanese: String?
    var titleSynonyms: [String]
    var airing: Bool
    var synopsis: String
    var type: String
    var source: String
    var status: String
    var aired: Aired?
    var duration: String
    var rating: String
    var score: Double
    var scoredBy: Int
    var popularity: Int
    var favourites: Int
    var members: Int
    var rank: Int
    var episodes: Int
    var background: String?
    var premiered: String?
    var broadcast: String?
    var related: Related
    var openingThemes: [String]?
    var endingThemes: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "mal_id"
        case url
        case imageUrl = "image_url"
        case trailerUrl = "trailer_url"
        case title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case airing
        case synopsis
        case type
        case source
        case status
        case aired
        case duration
        case rating
        case score
        case scoredBy = "scored_by"
        case popularity
        case favourites = "favorites"
        case members
        case rank
        case episodes
        case background
        case premiered
        case broadcast
        case related
        case openingThemes = "opening_themes"
        case endingThemes = "ending_themes"
        
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

struct Aired: Decodable {
    
    var from: String
    var to: String
    var prop: Prop
    var string: String
    
}

struct Prop: Decodable {
    
    var from: SpecificDate
    var to: SpecificDate
    
}

struct SpecificDate: Decodable {
    
    var day: Int
    var month: Int
    var year: Int
    
}

struct Related: Decodable {
    
    var Adaptation: [AnimeBrief]?
    var SideStory: [AnimeBrief]?
    var Summary: [AnimeBrief]?
    var producers: [AnimeBrief]?
    var licensors: [AnimeBrief]?
    var studios: [AnimeBrief]?
    var genres: [AnimeBrief]?
    
    enum CodingKeys: String, CodingKey {
        
        case Adaptation
        case SideStory = "Side story"
        
    }
    
}

struct AnimeBrief: Decodable {
    
    var id: Int
    var type: String
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "mal_id"
        case type
        case name
        case url
        
    }
    
}
