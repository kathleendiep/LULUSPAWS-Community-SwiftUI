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
// collection.document

class ProfileViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var following = 0
    @Published var followers = 0
    
    @Published var followCheck = false
    
    static var following = SignInViewModel.storeRoot.collection("following")
    static var followers = SignInViewModel.storeRoot.collection("followers")
    
    static func followingCollection(userid: String) -> CollectionReference {
        
        return following.document(userid).collection("following")
        
    }
    
    static func followersCollection(userid: String) -> CollectionReference {
        return followers.document(userid).collection("followers")
    }
    
    // following.following
    static func followingId(userId: String) -> DocumentReference {
        
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
        
    }
    
    // followers.followers
    static func followersId(userId: String) -> DocumentReference {
        return followers.document(userId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    func followState(userid: String) {
        ProfileViewModel.followingId(userId: userid).getDocument{
            
            (document, error) in
            if let doc = document, doc.exists {
                // if users id is here
                self.followCheck = true
            } else {
                self.followCheck = false
            }
        }
    }
    
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
    static func saveProfile(username: String, bio: String, petName: String, humanName: String, location: String, instagram: String, twitter: String, imageData: Data, onSuccess: @escaping(_ post: Post)-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
    
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        
        // converts the image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, username: username, bio: bio, petName: petName, humanName: humanName, location: location, instagram: instagram, twitter: twitter,  imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: onError)
        
    }
    
   
    // MARK: - DELETE
    
//    func deletePost(userId: String){
        /*
         - figure out what to do with the rest
         */
//     let db = Firestore.firestore()

//    Firestore.firestore().collection("posts").document(userid)
//        PostViewModel.PostsUserId(userId: userId).delete
//        let postId = PostViewModel.PostsUserId(userId: userId).collection("posts").document().documentID
        
//        PostViewModel.PostsUserId(userId: userId).delete {
//            (err) in
//
//            if err != nil {
//
//                print(err!.localizedDescription)
//
//                self.posts.removeAll { (post) in
//                    return post.id == userId
//                }
//
//            }
//
//        }
//
//    }
//
    
    
}
