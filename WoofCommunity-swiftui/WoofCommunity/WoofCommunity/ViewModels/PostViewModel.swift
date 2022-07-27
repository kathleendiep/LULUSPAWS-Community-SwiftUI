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

class PostViewModel: ObservableObject {
    
    // MARK: - Properties
    //  Firestore.firestore().collection(allPosts)
    static var Posts = SignInViewModel.storeRoot.collection("posts")
    
    static var AllPosts = SignInViewModel.storeRoot.collection("allPosts")
    
    static var Timeline = SignInViewModel.storeRoot.collection("timeline")
    
    
    
    // to fetch data
    //    @Published var user: User?
    //    @Published var users = [User]()
//    @Published var allPosts = [Post]()
    
    static func PostsUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping(_ post: Post)-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        //        let postId = self.PostsUserId(userId: userId).collection("posts").document().documentID
        let postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
        // add in the add data from PostService
        
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
    
    // CRUD
    /*
     - Create and add to an array
     @Published var posts = [Post]()
     - then fetch the data
     
     */
    // MARK: - LOAD/FETCH
    /*
     - 1) access this
     SignInViewModel.storeRoot.collection("allPosts")
     
     - 2) getDocuments
     .getDocuments
     
     - 3) Check for error
     
     - 4) Read through documents dictionary
     
     - 5) appendTo initiated array
     
     - 6) make a ViewModel for the Main or profile page and call function to add to Published array
     
     - 7) access this in the view
     ForEach(self.profileViewModel.posts, id: \.postId ) {
         (post) in
     }
     
     
     */
    
    static func getAllPosts(userId: String, onSuccess: @escaping(_ allPosts: [Post]) -> Void) {
        
        // 1) Access the collecton
        // 2) get document
        // Firestore.firestore().collection("allPosts")
        
        PostViewModel.PostsUserId(userId: userId).collection("posts").getDocuments{
            (snapshot, error) in
        
//        PostViewModel.AllPosts.getDocuments{ [self] (snapshot, error) in
//
            
            //  3) Check for error
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            // initiate the posts
            var allPosts = [Post]()
            
            // 4) Read through doucments dictionary
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? Post.init(fromDictionary: dict)
                else {
                    return
                }
                // 5) appendTo array
                allPosts.append(decoder)
            }
            onSuccess(allPosts)
        }
    }
    
}


