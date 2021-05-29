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
    @Published var topAnimes: TopAnimes?
    @Published var followingAnimes: [Anime] = [Anime]()
    
    @Published var detailAnime: DetailAnime?
    @Published var isFollowingAnime = false
    
    // User info
    @Published var loggedIn = false
    @Published var user = User()
    
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
    
    func followAnime(anime: DetailAnime) {
        
        if !user.followingAnimes.contains(where: { eachAnime in
            eachAnime.id == anime.id
        }) {
            
            let toFollowAnimes = Anime(id: anime.id, url: anime.url, imageUrl: anime.imageUrl, title: anime.title, type: anime.type, score: anime.score, members: anime.members, rank: anime.rank, episodes: anime.episodes)
            user.followingAnimes.append(toFollowAnimes)
        }
        
    }
    
    func unfollowAnime(anime: DetailAnime) {
        
        if user.followingAnimes.contains(where: { eachAnime in
            eachAnime.id == anime.id
        }) {
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
