//
//  AnimeViewModel.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import Foundation

class AnimeModel: ObservableObject {
    
    @Published var animes: Top?
    
    @Published var detailAnime: DetailAnime?
    
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
                    let result = try JSONDecoder().decode(Top.self, from: data)
                    
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
    
}
