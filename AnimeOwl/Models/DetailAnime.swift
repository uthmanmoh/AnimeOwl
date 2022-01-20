//
//  DetailAnime.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import Foundation

struct DetailAnimeParser: Decodable {
    var data: DetailAnime
}

class DetailAnime: Decodable, ObservableObject, Identifiable {
    
    var id: Int
    var url: String
    var images: Images?
    var title: String
    var titleEnglish: String?
    var titleJapanese: String?
    var titleSynonyms: [String]
    var airing: Bool
    var synopsis: String?
    var type: String
    var source: String
    var status: String
    var aired: Aired?
    var duration: String
    var rating: String
    var score: Double?
    var scoredBy: Int?
    var popularity: Int
    var favourites: Int
    var members: Int
    var rank: Int?
    var episodes: Int?
    var background: String?
    var broadcast: Broadcast?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "mal_id"
        case url
        case images
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
        case broadcast
        
    }
    
    init(id: Int = 0, url: String = "", images: Images?, title: String = "", titleEnglish:String = "", titleJapanese: String = "", titleSynonyms: [String] = [], airing: Bool = false, synopsis: String = "", type: String = "", source: String = "", status: String = "", aired: Aired?, duration: String = "", rating: String = "", score: Double = 0, scoredBy: Int = 0, popularity: Int = 0, favourites: Int = 0, members: Int = 0, rank: Int = 0, episodes: Int = 0, background: String = "", broadcast: Broadcast?) {
        self.id = id
        self.url = url
        self.images = images
        self.title = title
        self.titleEnglish = titleEnglish
        self.titleJapanese = titleJapanese
        self.titleSynonyms = titleSynonyms
        self.airing = airing
        self.synopsis = synopsis
        self.type = type
        self.source = source
        self.status = status
        self.aired = aired
        self.duration = duration
        self.rating = rating
        self.score = score
        self.scoredBy = scoredBy
        self.popularity = popularity
        self.favourites = favourites
        self.members = members
        self.rank = rank
        self.episodes = episodes
        self.background = background
        self.broadcast = broadcast
    }
    
}

struct Broadcast: Decodable {
    var day: String?
    var time: String?
    var timezone: String?
    var string: String?
}

struct Aired: Decodable {
    
    var from: String
    var to: String?
    var prop: Prop
    var string: String
    
}

struct Prop: Decodable {
    
    var from: SpecificDate
    var to: SpecificDate
    
}

struct SpecificDate: Decodable {
    
    var day: Int?
    var month: Int?
    var year: Int?
    
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
