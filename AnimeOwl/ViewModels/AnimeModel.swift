//
//  AnimeViewModel.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import Foundation
import Firebase

class AnimeModel: ObservableObject {
    
    @Published var animes: TopAnimes?
    
    @Published var detailAnime: DetailAnime?
    @Published var isFollowingAnime = false
    
    init() {
        
        getTopAnime()
        
    }
    
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
                        self.animes = result
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
    
    /// Checks if the user is following given anime and sets self.isFollowingAnime accordingly
    func checkFollowing(anime: DetailAnime) {
        
        let db = Firestore.firestore()
        let reference = db.collection("users").document(Auth.auth().currentUser!.uid)
        reference.getDocument { snapshot, error in
            guard error == nil, snapshot != nil else {
                print(error?.localizedDescription ?? "Error: Failed to get document info")
                return
            }
            
            let animeArray = snapshot!.data()?["followingAnimes"] as? [Int] ?? [Int]()
            DispatchQueue.main.async {
                self.isFollowingAnime = animeArray.contains(anime.id) ? true : false
            }
        }
        
    }
    
}
