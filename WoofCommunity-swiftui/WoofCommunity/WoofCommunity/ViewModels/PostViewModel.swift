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
import Combine
import FirebaseFirestoreSwift

// MARK: - FIREBASE STRUCTURE NOTES:
/*
 > users > userId >
 Firestore.firestore().collection("users").document(userId)
 
 > posts > documentId(userId) > posts > document().documentID
 //  Firestore.firestore().collection("posts").document(userId).collection("posts").document().documentID
 
 */

class PostViewModel: ObservableObject {
    
    // MARK: - Properties
    //  Firestore.firestore().collection(allPosts)
    static var Posts = SignInViewModel.storeRoot.collection("posts")

    static var AllPosts = SignInViewModel.storeRoot.collection("allPosts")
    
    static var Timeline = SignInViewModel.storeRoot.collection("timeline")

    @Published var allPosts = [Post]()
    
    static func PostsUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    // MARK: - CRUD
    /*
     - Create and add to an array
     @Published var posts = [Post]()
     - then fetch the data
     */
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping(_ post: Post)-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        // This is just the post id
        let postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
        
        // this appends to postId
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

//
//     MARK: - LOAD/FETCH - NOTES
//    /*
//     - 1) access this
//     SignInViewModel.storeRoot.collection("allPosts")
//
//     - 2) getDocuments
//     .getDocuments
//
//     - 3) Check for error
//
//     - 4) Read through documents dictionary
//
//     - 5) appendTo initiated array (then add to actual published array later)
//
//     - 6) make a ViewModel for the Main or profile page and call function to add DATA to Published array
//
//     - 7) access this in the view
//     ForEach(self.profileViewModel.posts, id: \.postId ) {
//         (post) in
//     }
//     */
//
