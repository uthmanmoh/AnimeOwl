////
////  Anime.swift
////  Anime Reviews App
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

struct Search: Decodable {
    var results: [Result]
}

struct Result: Decodable {
    var mal_id: Int
    var url: String
    var image_url: String
    var title: String
    var airing: Bool
    var synopsis: String
    var type: String
    var score: Double
    var start_date: String?
    var end_date: String?
    var members: Int
    var rated: String?
    var episodes: Int
}
