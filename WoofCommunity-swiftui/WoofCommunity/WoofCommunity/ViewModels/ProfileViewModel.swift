//
//  ProfileViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth


// to show posts in the profile
class ProfileViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    
    func loadUserPosts(userId: String) {
        
        // in the PostViewModel initialized the user
        PostViewModel.loadUserPosts(userId: userId) {
            (posts) in
            
            // put in the profile posts
            self.posts = posts
                    
        }
    }

    // MARK: - PROFILE
    // StorageService.editProfile
    static func saveProfile(username: String, bio: String, petName: String, humanName: String, imageData: Data, onSuccess: @escaping(_ post: Post)-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
    
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        
        // converts the image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, username: username, bio: bio, petName: petName, humanName: humanName,  imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: onError)
        
    }
    
   
    // MARK: - DELETE
    
//    func deletePost(id: String){
//        
//        // id of document
//        SignInViewModel.storeRoot.collection("posts").document(id).delete { (err) in
//            
//            if err != nil {
//                
//                print(err!.localizedDescription)
//                
//                self.posts.removeAll { (post) in
//                    return post.id == id
//                }
//                
//            }
//            
//            
//        }
//
//    }
    
    
//
//    static func deletePost(userId: String, onSuccess: @escaping(_ post: Post) -> Void) {
//
//
//            PostViewModel.Posts.document(userId).delete
//
//            self.posts.removeAll {
//                post in
//                return user.id == userId
//            }
//
//
//
//
//
//
//
//        if let documentId = self.posts.postId {
//
//            var postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
//
//
//        }
//        // delete based on postId
//
//
//        // match this postId to document
//        PostViewModel.Posts.document(postId).delete { error in
//            if error == nil {
//                DispatchQueue.main.async {
//
//                   // Remove the post
//                   posts.removeAll { post in
//                       return self.posts. == postId
//                   }
//
//               }
//            }
//        }
//
//
//
//    }
    //todo: #15 - add follows and followers
    
}
