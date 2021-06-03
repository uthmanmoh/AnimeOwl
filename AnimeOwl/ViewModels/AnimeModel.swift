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
    
    @Published var upcomingAnimes: [DayAnime]?
    
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
                    
                    for eachDay in DaysOfWeek.allCases {
                        for anime in result.getCurrentDay(forDay: eachDay.title) {
                            anime.getImageData()
                            anime.getAirDate()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.weeklyAnime = result
//                        print("BEFORE FIXINGF WEEKLY ANIME: \(self.weeklyAnime!.monday.count + self.weeklyAnime!.tuesday.count + self.weeklyAnime!.wednesday.count + self.weeklyAnime!.thursday.count + self.weeklyAnime!.friday.count + self.weeklyAnime!.saturday.count + self.weeklyAnime!.sunday.count)")
                        self.fixWeeklyAnimes()
//                        print("AFTERRR FIXINGF WEEKLY ANIME: \(self.weeklyAnime!.monday.count + self.weeklyAnime!.tuesday.count + self.weeklyAnime!.wednesday.count + self.weeklyAnime!.thursday.count + self.weeklyAnime!.friday.count + self.weeklyAnime!.saturday.count + self.weeklyAnime!.sunday.count)")
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
    
    func fixWeeklyAnimes() {
        
        for anime in self.weeklyAnime!.monday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "monday" {
                    
                    let index = self.weeklyAnime!.monday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.monday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.monday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.tuesday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "tuesday" {
                    
                    let index = self.weeklyAnime!.tuesday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.tuesday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.tuesday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.wednesday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "wednesday" {
                    
                    let index = self.weeklyAnime!.wednesday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.wednesday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.wednesday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.thursday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "thursday" {
                    
                    let index = self.weeklyAnime!.thursday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.thursday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.thursday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.friday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "friday" {
                    
                    let index = self.weeklyAnime!.friday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.friday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.friday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.saturday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "saturday" {
                    
                    let index = self.weeklyAnime!.saturday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.saturday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
        }
        
        weeklyAnime!.saturday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
        for anime in self.weeklyAnime!.sunday {
            if let curDay = anime.day?.lowercased() {
                if curDay != "sunday" {
                    
                    let index = self.weeklyAnime!.sunday.firstIndex(where: {$0 === anime})
                    self.weeklyAnime!.sunday.remove(at: index!)
                    
                    addToCorrectArray(arr: self.weeklyAnime!, anime: anime, curDay: curDay)
                    
                }
            }
            
        }
        
        weeklyAnime!.sunday.sort(by: {$0.score ?? 0 > $1.score ?? 0} )
        
    }
    
    func addToCorrectArray(arr: WeeklyAnime, anime: DayAnime, curDay: String) {
        
        if curDay == "monday" {
            arr.monday.append(anime)
        } else if curDay == "tuesday" {
            arr.tuesday.append(anime)
        } else if curDay == "wednesday" {
            arr.wednesday.append(anime)
        } else if curDay == "thursday" {
            arr.thursday.append(anime)
        } else if curDay == "friday" {
            arr.friday.append(anime)
        } else if curDay == "saturday" {
            arr.saturday.append(anime)
        } else if curDay == "sunday" {
            arr.sunday.append(anime)
        }
        
    }
    
    func resetDetailAnime() {
        DispatchQueue.main.async {
            self.detailAnime = nil
        }
    }
    
    func setUpcomingAnimes() {
        
        guard self.weeklyAnime != nil else { return }
        
        self.upcomingAnimes = [DayAnime]()
        var count = 0
        outerloop: for eachDay in DaysOfWeek.allCases {
            for anime in self.weeklyAnime!.getCurrentDay(forDay: eachDay.title) {
                self.upcomingAnimes?.append(anime)
                count += 1
                if count > 10 { break outerloop }
            }
        }
        
        self.upcomingAnimes!.sort { first, second in
            // Fix this sorting algorithm
            let now = Date()
            if let firstDate = first.date, let secondDate = second.date {
                return firstDate.distance(to: now) < secondDate.distance(to: now)
            } else {
                return false
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
            self.currentView = .calendar
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
