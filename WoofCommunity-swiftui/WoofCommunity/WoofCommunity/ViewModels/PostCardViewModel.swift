//
//  PostCardViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
    
    @Published var post: Post!
    @Published var isLiked = false
    
    func hasLikedPost() {
        isLiked =  (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true: false
    }
    
    func like() {
        post.likeCount == 1
        isLiked = true
        
        PostViewModel.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostViewModel.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        // Liked - ser the userId to posts owner id
        PostViewModel.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        PostViewModel.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostViewModel.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        // Liked - ser the userId to posts owner id
        PostViewModel.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    
}
