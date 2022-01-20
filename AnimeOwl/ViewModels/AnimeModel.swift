//
//  AnimeViewModel.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import Foundation
import Firebase

class AnimeModel: ObservableObject {
    
    // Anime info
    @Published var topAnimes: TopAnimes = TopAnimes(data: [Anime]())
    @Published var followingAnimes: [Anime] = [Anime]()
    
    @Published var detailAnime: DetailAnime?
    
    @Published var isFollowingAnime = false
    
    
    @Published var mondayAnime: [DetailAnime] = [DetailAnime]()
    @Published var tuesdayAnime: [DetailAnime] = [DetailAnime]()
    @Published var wednesdayAnime: [DetailAnime] = [DetailAnime]()
    @Published var thursdayAnime: [DetailAnime] = [DetailAnime]()
    @Published var fridayAnime: [DetailAnime] = [DetailAnime]()
    @Published var saturdayAnime: [DetailAnime] = [DetailAnime]()
    @Published var sundayAnime: [DetailAnime] = [DetailAnime]()
    
    @Published var upcomingAnimes: [DetailAnime] = [DetailAnime]()
    
    // User info
    @Published var loggedIn = false
    @Published var user = User()
    
    // UI Info
    @Published var currentView: SideMenuOptions = .home
    
    // MARK: - Anime Data Methods
    func getTopAnime() {
        
        let url = URL(string: "\(Constants.API_URL)/top/anime")!
        //let url = URL(string: "\(Constants.API_URL)/search/anime?q=Shingekipage=1")!
        //let url = URL(string: "\(Constants.API_URL)/schedule/monday")!
        //let url = URL(string: "\(Constants.API_URL)/top/anime/1/movie")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    let result = try JSONDecoder().decode(TopAnimes.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.topAnimes = result
                    }
                } catch {
                    print(error)
                }
                
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        
        task.resume()
        
    }
    
    func getDetailAnime(id: Int) {
        
        let url = URL(string: "\(Constants.API_URL)/anime/\(id)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    let result = try JSONDecoder().decode(DetailAnimeParser.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.detailAnime = result.data
                        self.checkFollowing(anime: self.detailAnime!)
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        
        task.resume()
        
    }
    
    func getWeekdayAnime() {
        
        let url = URL(string: "\(Constants.API_URL)/schedules")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    let result = try JSONDecoder().decode(WeeklyAnimeParser.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.addToCorrectArray(arr: result.data)
                        self.setUpcomingAnimes(result.data)
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        
        task.resume()
        
    }
    
    func addToCorrectArray(arr: [DetailAnime]) {
        
        for anime in arr {
            if anime.broadcast == nil {
                continue
            } else if anime.broadcast!.day == nil {
                continue
            }
            
            if anime.broadcast!.day!.lowercased().contains("monday") {
                self.mondayAnime.append(anime)
            } else if anime.broadcast!.day!.lowercased().contains("tuesday") {
                self.tuesdayAnime.append(anime)
            } else if anime.broadcast!.day!.lowercased().contains("wednesday") {
                self.wednesdayAnime.append(anime)
            } else if anime.broadcast!.day!.lowercased().contains("thursday") {
                self.thursdayAnime.append(anime)
            } else if anime.broadcast!.day!.lowercased().contains("friday") {
                self.fridayAnime.append(anime)
            } else if anime.broadcast!.day!.lowercased().contains("saturday") {
                self.saturdayAnime.append(anime)
            } else {
                self.sundayAnime.append(anime)
            }
        }
        
    }
    
    func returnArrayBasedOn(day: String) -> [DetailAnime]? {
        if day.lowercased() == "monday" {
            return mondayAnime
        } else if day.lowercased() == "tuesday" {
            return tuesdayAnime
        } else if day.lowercased() == "wednesday" {
            return wednesdayAnime
        } else if day.lowercased() == "thursday" {
            return thursdayAnime
        } else if day.lowercased() == "friday" {
            return fridayAnime
        } else if day.lowercased() == "saturday" {
            return saturdayAnime
        } else {
            return sundayAnime
        }
    }
    
    func resetDetailAnime() {
        DispatchQueue.main.async {
            self.detailAnime = nil
        }
    }
    
    func setUpcomingAnimes(_ array: [DetailAnime]) {
        // TODO: Fix error with upcoming animes not getting appended anything
        for anime in array {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let animeDate = dateFormatter.date(from: anime.aired?.from ?? "2999-12-31")
            if let animeDate = animeDate, let aired = anime.aired, animeDate > Date() || aired.from == "" {
                upcomingAnimes.append(anime)
            }
                
        }
        
    }
    
    
    // MARK: - User Methods
    
    /// sets self.followingAnimes based on user.followingAnimes
    func setFollowingAnimes() {
        DispatchQueue.main.async {
            self.followingAnimes = self.user.followingAnimes
        }
    }
    
    func checkLogin() {
        loggedIn = Auth.auth().currentUser == nil ? false: true
        
        DispatchQueue.main.async {
            self.currentView = .home
        }
        
        if self.user.username == "" {
            getUserData()
        }
    }
    
    func getUserData() {
        
        guard Auth.auth().currentUser != nil else { return }
        
        let db = Firestore.firestore()
        let reference = db.collection("users").document(Auth.auth().currentUser!.uid)
        reference.getDocument { snapshot, error in
            guard error == nil, snapshot != nil else {
                print(error!.localizedDescription)
                return
            }
            
            let data = snapshot!.data()
            self.user.username = data?["username"] as? String ?? ""
            
            if let databaseInfo = data?["followingAnimes"] as? [[String: Any]] {
                
                // Set self.user.followingAnimes to the data from database
                for a in databaseInfo {
                    let newAnime = Anime(id: a["id"] as! Int,
                                         url: a["url"] as! String,
                                         images: a["images"] as! Images?,
                                         title: a["title"] as! String,
                                         type: a["type"] as! String,
                                         score: a["score"] as? Double,
                                         members: a["members"] as! Int,
                                         rank: a["rank"] as? Int,
                                         episodes: a["episodes"] as? Int)
                    
                    self.user.followingAnimes.append(newAnime)
                }
            }
            
        }
        
    }
    
    func saveUserData() {
        
        if let currentUser = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let reference = db.collection("users").document(currentUser.uid)
            
            var animesArray = [[String: Any]]()
            for anime in user.followingAnimes {
                animesArray.append(["id": anime.id, "url": anime.url, "imageUrl": anime.images as Any, "title": anime.title, "type": anime.type, "score": anime.score as Any as Any, "members": anime.members, "rank": anime.rank as Any, "episodes": anime.episodes ?? 0])
            }
            
            reference.updateData(["followingAnimes": FieldValue.delete()]) { error in
                if error != nil {
                    print(error.debugDescription)
                }
            }
            
            reference.updateData(["followingAnimes": animesArray]) { error in
                if error != nil {
                    print(error.debugDescription)
                }
            }
        }
        
    }
    
    func updateFollowing(forAnime anime: DetailAnime) {
        
        if !user.followingAnimes.contains(where: { eachAnime in
            eachAnime.id == anime.id
        }) && isFollowingAnime {
            
            let toFollowAnimes = Anime(id: anime.id, url: anime.url, images: anime.images, title: anime.title, type: anime.type, score: anime.score, members: anime.members, rank: anime.rank, episodes: anime.episodes)
            user.followingAnimes.append(toFollowAnimes)
        } else {
            
            // Remove anime from user.followingAnimes
            for index in 0 ..< user.followingAnimes.count {
                if user.followingAnimes[index].id == anime.id {
                    user.followingAnimes.remove(at: index)
                    break
                }
            }
        }
        
    }
    
    func checkFollowing(anime: DetailAnime) {
        DispatchQueue.main.async {
            self.isFollowingAnime = self.user.followingAnimes.contains(where: { eachAnime in
                eachAnime.id == anime.id
            })
        }
        
    }
    
}
