//
//  FollowViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import Foundation
import Firebase

class FollowViewModel: ObservableObject {
    
    func updateFollowCount(userId: String, followingCount: @escaping (_ followingCount: Int) -> Void, followersCount: @escaping (_ followingCount: Int) -> Void) {
        
        ProfileViewModel.followingCollection(userid: userId).getDocuments{
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
        
        ProfileViewModel.followersCollection(userid: userId).getDocuments{
            
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
    }
    
    func manageFollow(userId: String, followCheck: Bool, followingCount: @escaping (_ followingCount: Int) -> Void, followersCount: @escaping (_ followingCount: Int) -> Void) {
        
        if !followCheck {
            follow(userId: userId, followingCount: followingCount , followersCount: followersCount )
        } else {
            unfollow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        }
    }
    
    func follow(userId: String, followingCount: @escaping (_ followingCount: Int) -> Void, followersCount: @escaping (_ followingCount: Int) -> Void){
        
        ProfileViewModel.followingId(userId: userId).setData([:]){
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        ProfileViewModel.followersId(userId: userId).setData([:]){
            
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }

    }
    
    func unfollow(userId: String, followingCount: @escaping (_ followingCount: Int) -> Void, followersCount: @escaping (_ followingCount: Int) -> Void){
        
        ProfileViewModel.followingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)

            }
            
        }
        
        ProfileViewModel.followersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
  
            }
        }
    }
}
