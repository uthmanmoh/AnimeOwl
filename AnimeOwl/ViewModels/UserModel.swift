////
////  UserModel.swift
////  AnimeOwl
////
////  Created by Uthman Mohamed on 2021-05-22.
////
//
//import Foundation
//import FirebaseAuth
//import Firebase
//
//class UserModel: ObservableObject {
//    
//    @Published var loggedIn = false
//    
//    @Published var user = User()
//    
//    func checkLogin() {
//        loggedIn = Auth.auth().currentUser == nil ? false: true
//        
//        if self.user.username == "" {
//            getUserData()
//        }
//    }
//    
//    func getUserData() {
//        
//        guard Auth.auth().currentUser != nil else { return }
//        
//        let db = Firestore.firestore()
//        let reference = db.collection("users").document(Auth.auth().currentUser!.uid)
//        reference.getDocument { snapshot, error in
//            guard error == nil, snapshot != nil else {
//                print(error?.localizedDescription ?? "Error getting document")
//                return
//            }
//            
//            let data = snapshot!.data()
//            self.user.username = data?["username"] as? String ?? ""
//            self.user.followingAnimes = data?["followingAnimes"] as? [Anime] ?? [Anime]()
//        }
//        
//    }
//    
//    func followAnime(anime: DetailAnime) {
//        
//        if !user.followingAnimes.contains(where: { eachAnime in
//            eachAnime.id == anime.id
//        }) {
//            
//            let toFollowAnimes = Anime(id: anime.id, url: anime.url, imageUrl: anime.imageUrl, title: anime.title, type: anime.type, score: anime.score, members: anime.members, rank: anime.rank, episodes: anime.episodes)
//            user.followingAnimes.append(toFollowAnimes)
//        }
//        
//    }
//    
//    func unfollowAnime(anime: DetailAnime) {
//        
//        if user.followingAnimes.contains(where: { eachAnime in
//            eachAnime.id == anime.id
//        }) {
//            // Remove anime from user.followingAnimes
//            for index in 0 ..< user.followingAnimes.count {
//                if user.followingAnimes[index].id == anime.id {
//                    user.followingAnimes.remove(at: index)
//                    break
//                }
//            }
//            
//        }
//        
//    }
//    
//    func saveData() {
//        
//        if let currentUser = Auth.auth().currentUser {
//            let db = Firestore.firestore()
//            let reference = db.collection("users").document(currentUser.uid)
//            
//            reference.updateData(["followingAnimes": self.user.followingAnimes]) { error in
//                if error != nil {
//                    print(error?.localizedDescription ?? "Error writing followingAnimes to database")
//                }
//            }
//        }
//        
//    }
//}
