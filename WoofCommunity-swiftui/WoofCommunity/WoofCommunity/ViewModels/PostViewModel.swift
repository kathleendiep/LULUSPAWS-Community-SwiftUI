//
//  PostViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/20/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class PostViewModel {
    
    // MARK: - Properties
    static var Posts = SignInViewModel.storeRoot.collection("posts")
    
    static func PostsUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static var AllPosts = SignInViewModel.storeRoot.collection("allPosts")
    
    static var Timeline = SignInViewModel.storeRoot.collection("timeline")
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping()-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
 
        let postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(user: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
    
    
}
