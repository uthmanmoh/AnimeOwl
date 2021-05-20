//
//  AnimeViewModel.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import Foundation

class AnimeModel: ObservableObject {
    
    @Published var animes: Top?
    
    init() {
        
        getAnimeList()
        
    }
    
    func getAnimeList() {
        
        let url = URL(string: "\(Constants.API_URL)/top/anime/1")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //          if let response = response {
            //            print(response)
            //
            //            if let data = data, let body = String(data: data, encoding: .utf8) {
            //                print("Data = ", data)
            //                print("Body = ", body)
            //            }
            //          } else {
            //            print(error ?? "Unknown error")
            //          }
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
    
}
