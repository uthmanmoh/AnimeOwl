//
//  AnimeViewModel.swift
//  Anime Reviews App
//
//  Created by Uthman Mohamed on 2021-05-06.
//

import Foundation

class AnimeViewModel: ObservableObject {
    
    @Published var search: Search?
    
    init() {
        
        getLocalData()
        
    }
    
    func getLocalData() {
        
        let url = URL(string: "https://api.jikan.moe/v3/top/characters")!
        
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
                let result = try JSONDecoder().decode(Search.self, from: data)
                
                self.search = result
                print(self.search?.results[0].title ?? "nothing found :(")
                } catch {
                    print(error)
                }
                
            } else {
                print(error ?? "Unknown Error")
            }
        }

        task.resume()
        
    }
    
}
