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
    
   //  Firestore.firestore().collection(allPosts)
    static var AllPosts = SignInViewModel.storeRoot.collection("allPosts")
    
    static var Timeline = SignInViewModel.storeRoot.collection("timeline")
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping()-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let postId = self.PostsUserId(userId: userId).collection("posts").document().documentID
        //        let postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
    
    static func loadUserPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        
        PostViewModel.PostsUserId(userId: userId).collection("posts").getDocuments{
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            // initiate the posts
            var posts = [Post]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? Post.init(fromDictionary: dict)
                else {
                    return
                }
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
}
