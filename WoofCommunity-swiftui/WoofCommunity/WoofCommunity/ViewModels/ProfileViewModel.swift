//
//  ProfileViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import Foundation
import Firebase

// to show posts in the profile
class ProfileViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    func loadUserPosts(userId: String) {
        PostViewModel.loadUserPosts(userId: userId) {
            (posts) in
            
            // put in the profile posts
            self.posts = posts
        }
    }
    
    //todo: #15 - add follows and followers
    
}
