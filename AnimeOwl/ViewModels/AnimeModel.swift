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
    @Published var topAnimes: TopAnimes = TopAnimes(top: [Anime]())
    @Published var followingAnimes: [Anime] = [Anime]()
    
    @Published var detailAnime: DetailAnime?
    
    @Published var isFollowingAnime = false
    
    @Published var weeklyAnime: WeeklyAnime?
    
    // User info
    @Published var loggedIn = false
    @Published var user = User()
    
    // UI Info
    @Published var currentView: SideMenuOptions = .home
    
    // MARK: - Anime Data Methods
    func getTopAnime() {
        
        let url = URL(string: "\(Constants.API_URL)/top/anime/1")!
        //let url = URL(string: "\(Constants.API_URL)/search/anime?q=Shingekipage=1")!
        //let url = URL(string: "\(Constants.API_URL)/schedule/monday")!
        //let url = URL(string: "\(Constants.API_URL)/top/anime/1/movie")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    let result = try JSONDecoder().decode(TopAnimes.self, from: data)
                    
                    for anime in result.top {
                        anime.getImageData()
                    }
                    
                    DispatchQueue.main.async {
                        self.topAnimes = result
                    }
                } catch {
                    print(error.localizedDescription)
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
                    let result = try JSONDecoder().decode(DetailAnime.self, from: data)
                    
                    result.getImageData()
                    
                    DispatchQueue.main.async {
                        self.detailAnime = result
                        self.checkFollowing(anime: self.detailAnime!)
                    }
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        
        task.resume()
        
    }
    
    func getWeekdayAnime() {
        
        let url = URL(string: "\(Constants.API_URL)/schedule/")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    let result = try JSONDecoder().decode(WeeklyAnime.self, from: data)
                    
                    for eachDay in Constants.daysOfTheWeek {
                        for anime in result.getCurrentDay(forDay: eachDay)! {
                            anime.getImageData()
                            anime.getAirDate()
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.fixWeeklyAnimes(weeklyAnime: result)
                        self.weeklyAnime = result
                    }
                    
                    
                } catch {
                    print(error.localizedDescription)
                    print(error as Any)
                }
                
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
        
        task.resume()
        
    }
    
    func fixWeeklyAnimes(weeklyAnime arr: WeeklyAnime) {
        
        for anime in arr.monday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "monday" {
                    
                    let index = arr.monday.firstIndex(where: {$0 === anime})
                    arr.monday.remove(at: index!)
                    
                    if curDay == "sunday" {
                        arr.sunday.append(anime)
                    } else if curDay == "tuesday" {
                        arr.tuesday.append(anime)
                    } else if curDay == "wednesday" {
                        arr.wednesday.append(anime)
                    } else {
                        arr.saturday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.tuesday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "tuesday" {
                    
                    let index = arr.tuesday.firstIndex(where: {$0 === anime})
                    arr.tuesday.remove(at: index!)
                    
                    if curDay == "monday" {
                        arr.monday.append(anime)
                    } else if curDay == "wednesday" {
                        arr.wednesday.append(anime)
                    } else if curDay == "thursday" {
                        arr.thursday.append(anime)
                    } else {
                        arr.sunday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.wednesday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "wednesday" {
                    
                    let index = arr.wednesday.firstIndex(where: {$0 === anime})
                    arr.wednesday.remove(at: index!)
                    
                    if curDay == "tuesday" {
                        arr.tuesday.append(anime)
                    } else if curDay == "thursday" {
                        arr.thursday.append(anime)
                    } else if curDay == "friday" {
                        arr.friday.append(anime)
                    } else {
                        arr.monday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.thursday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "thursday" {
                    
                    let index = arr.thursday.firstIndex(where: {$0 === anime})
                    arr.thursday.remove(at: index!)
                    
                    if curDay == "wednesday" {
                        arr.wednesday.append(anime)
                    } else if curDay == "friday" {
                        arr.friday.append(anime)
                    } else if curDay == "saturday" {
                        arr.saturday.append(anime)
                    } else {
                        arr.tuesday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.friday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "friday" {
                    
                    let index = arr.friday.firstIndex(where: {$0 === anime})
                    arr.friday.remove(at: index!)
                    
                    if curDay == "thursday" {
                        arr.thursday.append(anime)
                    } else if curDay == "saturday" {
                        arr.saturday.append(anime)
                    } else if curDay == "sunday" {
                        arr.sunday.append(anime)
                    } else {
                        arr.wednesday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.saturday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "saturday" {
                    
                    let index = arr.saturday.firstIndex(where: {$0 === anime})
                    arr.saturday.remove(at: index!)
                    
                    if curDay == "sunday" {
                        arr.sunday.append(anime)
                    } else if curDay == "friday" {
                        arr.friday.append(anime)
                    } else if curDay == "monday" {
                        arr.monday.append(anime)
                    } else {
                        arr.thursday.append(anime)
                    }
                    
                }
            }
        }
        
        for anime in arr.sunday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "sunday" {
                    
                    let index = arr.sunday.firstIndex(where: {$0 === anime})
                    arr.sunday.remove(at: index!)
                    
                    if curDay == "monday" {
                        arr.monday.append(anime)
                    } else if curDay == "tuesday" {
                        arr.tuesday.append(anime)
                    } else if curDay == "friday" {
                        arr.friday.append(anime)
                    } else {
                        arr.saturday.append(anime)
                    }
                    
                }
            }
            
        }
        
    }
    
    
    func resetDetailAnime() {
        DispatchQueue.main.async {
            self.detailAnime = nil
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
                print(error?.localizedDescription ?? "Error getting document")
                return
            }
            
            let data = snapshot!.data()
            self.user.username = data?["username"] as? String ?? ""
            
            if let databaseInfo = data?["followingAnimes"] as? [[String: Any]] {
                
                // Set self.user.followingAnimes to the data from database
                for a in databaseInfo {
                    let newAnime = Anime(id: a["id"] as! Int,
                                         url: a["url"] as! String,
                                         imageUrl: a["imageUrl"] as? String? ?? nil,
                                         title: a["title"] as! String,
                                         type: a["type"] as! String,
                                         score: a["score"] as! Double,
                                         startDate: a["startDate"] as? String? ?? nil,
                                         endDate: a["endDate"] as? String? ?? nil,
                                         members: a["members"] as! Int,
                                         rank: a["rank"] as! Int,
                                         episodes: a["episodes"] as! Int)
                    
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
                animesArray.append(["id": anime.id, "url": anime.url, "imageUrl": anime.imageUrl as Any, "title": anime.title, "type": anime.type, "score": anime.score, "startDate": anime.startDate as Any, "endDate": anime.endDate as Any, "members": anime.members, "rank": anime.rank, "episodes": anime.episodes])
                
            }
            
            reference.setData(["followingAnimes": animesArray, "username": user.username]) { error in
                if error != nil {
                    print(error?.localizedDescription ?? "Error setting data in AnimeModel.saveUserData()")
                }
            }
        }
        
    }
    
    func updateFollowing(forAnime anime: DetailAnime) {
        
        if !user.followingAnimes.contains(where: { eachAnime in
            eachAnime.id == anime.id
        }) && isFollowingAnime {
            
            let toFollowAnimes = Anime(id: anime.id, url: anime.url, imageUrl: anime.imageUrl, title: anime.title, type: anime.type, score: anime.score, members: anime.members, rank: anime.rank, episodes: anime.episodes)
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
