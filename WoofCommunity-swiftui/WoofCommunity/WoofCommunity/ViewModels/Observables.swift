////
////  Observables.swift
////  WoofCommunity
////
////  Created by Kathleen Diep on 7/27/22.
////
//
//import SwiftUI
//import Firebase
//
//
//class getData : ObservableObject{
//    
//    @Published var allPosts = [Post]()
//    
//    init() {
//        
//        let db = Firestore.firestore()
//        
//        db.collection("allPosts").addSnapshotListener { (snap, err) in
//            
//            if err != nil{
//                
//                print((err?.localizedDescription)!)
//                return
//            }
//            
//            for i in snap!.documentChanges{
//                
//                if i.type == .added{
//                    
//                    print("hello world")
//                    // document id
//                    let id = i.document.documentID
//                    let caption = i.document.get("name") as! String
//                    let geoLocation = i.document.get("geoLocation") as! String
//                    let ownerId = i.document.get("ownerId") as! String
//                    let postId = i.document.get("postId") as! String
//                    let username = i.document.get("username") as! String
//                    let profile = i.document.get("profile") as! String
//                    let mediaUrl = i.document.get("mediaUrl") as! String
//                    
//                    DispatchQueue.main.async {
//                    
//                        self.allPosts.append(datatype(id: id, caption: caption, geoLocation: geoLocation, ownerId: ownerId, postId: postId, username: username, profile: profile, mediaUrl: mediaUrl))
//                        
//                    }
//                    
//                }
//            }
//        }
//        
//        
//    }
//    
//}
