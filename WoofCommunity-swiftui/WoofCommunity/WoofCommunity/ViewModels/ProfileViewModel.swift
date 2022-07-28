//
//  ProfileViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import Foundation
import Firebase
import FirebaseStorage

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
    
    // StorageService.editProfile
    static func saveProfile(username: String, bio: String, petName: String, humanName: String, imageData: Data, onSuccess: @escaping(_ post: Post)-> Void, onError: @escaping (_ errorMessage: String) -> Void) {
    
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        
        // converts the image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, username: username, bio: bio, petName: petName, humanName: humanName,  imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: onError)
        
    }
    
   
    //todo: #15 - add follows and followers
    
}
