////
////  AnimeModel.swift
////  Anime Reviews App
////
////  Created by Uthman Mohamed on 2021-05-06.
////
//
//import Foundation
//
//class AnimeModel: ObservableObject {
//    
//    @Published var animes = Animes()
//    
//    init() {
//        getLocalData()
//    }
//    
//    func getLocalData() {
//        
//        let pathString = Bundle.main.path(forResource: "allAnime", ofType: "json")
//
//        guard pathString != nil else { return }
//        
//        let url = URL(fileURLWithPath: pathString!)
//        
//        let data = try? Data(contentsOf: url)
//        
//        guard data != nil else { return }
//        
//        do {
//            let results = try JSONDecoder().decode(Animes.self, from: data!)
//            
//            
//            for item in results.data {
//                item.id = UUID()
//            }
//            
//            animes = results
//            
//        } catch {
//            print(error)
//        }
//
//        
//    }
//    
//}
