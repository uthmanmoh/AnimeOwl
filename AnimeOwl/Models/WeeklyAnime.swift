//
//  WeeklyAnime.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-29.
//

import Foundation

class WeeklyAnime: Decodable {
    
    var monday: [DayAnime]
    var tuesday: [DayAnime]
    var wednesday: [DayAnime]
    var thursday: [DayAnime]
    var friday: [DayAnime]
    var saturday: [DayAnime]
    var sunday: [DayAnime]
    
    func getCurrentDay(forDay day: String) -> [DayAnime] {
        if day.lowercased() == "monday" {
            return self.monday
        } else if day.lowercased() == "tuesday" {
            return self.tuesday
        } else if day.lowercased() == "wednesday" {
            return self.wednesday
        } else if day.lowercased() == "thursday" {
            return self.thursday
        } else if day.lowercased() == "friday" {
            return self.friday
        } else if day.lowercased() == "saturday" {
            return self.saturday
        } else { // sunday
            return self.sunday
        }
    }
    
}

class DayAnime: Decodable, ObservableObject, Identifiable {
    
    @Published var imageData: Data?
    @Published var date: Date?
    @Published var day: String?
    @Published var airTime: String?
    
    var id: Int
    var url: String?
    var imageUrl: String?
    var title: String?
    var synopsis: String?
    var type: String?
    var members: Int?
    var episodes: Int?
    var airingStart: String?
    var genres: [AnimeBrief]?
    var score: Double?
    var producers: [AnimeBrief]?
    var source: String?
    var licensors: [String]?
    var rated18: Bool?
    var forKids: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url
        case imageUrl = "image_url"
        case title
        case synopsis
        case type
        case members
        case episodes
        case airingStart = "airing_start"
        case genres
        case score
        case producers
        case source
        case licensors
        case rated18 = "r18"
        case forKids = "kids"
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
                    print(error.debugDescription)
                }
            }.resume()
        }
    }
    
    func getAirDate() {
        guard airingStart != nil else { return }
        
        if let date = ISO8601DateFormatter().date(from: self.airingStart!) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let time = formatter.string(from: date)
            
            let weekday = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
            
            DispatchQueue.main.async {
                self.date = date
                self.day = weekday
                self.airTime = time
            }
        } else {
            print("Failed to set date for \(title ?? "Some anime")")
        }
        
    }

    
}
