//
//  Storage.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/14/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

/*
 
 - StorageService - adds to storage
 - UsersService -
 */

class StorageService {
    
    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference()
    
    // storage
    static var storageProfile = storageRoot.child("profile")
    
    static var storagePost = storageRoot.child("posts")
    
    // posts/postid
    static func storagePostId(postId:String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    // MARK: - PROFILES
    // storage.reference().child("profile").child("userId")
    // profile/userid
    static func storageProfileId(userId:String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    static func editProfile(userId: String, username: String, bio: String, petName: String, humanName: String, location: String, instagram: String, twitter: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference,onError: @escaping(_ errorMessage: String) -> Void){
        
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL{
                (url,error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = SignInViewModel.getUserId(userId)
                    
                    // update the data
                    firestoreUserId.updateData(["profileImageUrl": metaImageUrl, "username": username, "bio": bio, "petName":petName, "humanName":humanName, "location": location, "instagram":instagram, "twitter":twitter])
                    
                }
            }
        }
    }
    
    static func saveProfileImage(userId: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        
        // MetaData - image info
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            // get the image = metaImageUrl
            storageProfileImageRef.downloadURL{
                (url,error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    // check if user is logged in
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = SignInViewModel.getUserId(userId)
                    
                    // match these to variables to the above ones
                    let user = User.init(id: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "",  searchName: username.splitString(), petName: "", humanName: "", profileDogImageUrl: "", location: "", twitter:"", instagram:"")
                    
                    // if has user
                    guard let dict = try?user.asDictionary() else {return}
                    
                    firestoreUserId.setData(dict){
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    
                    onSuccess(user)
                }
            }
        }
        
    }
    
    // MARK: - Posts
    static func savePostPhoto(userId: String, caption: String, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping(_ post: Post) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        
        // put the data
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.downloadURL{
                (url,error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    // access the collection
                    let firestorePostRef = PostViewModel.PostsUserId(userId: userId).collection("posts").document(postId)
                    
                    let post = Post.init(caption: caption, geoLocation: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likes: [:], likeCount: 0)
                    
                    // help: put in dictionary
                    guard let dict = try? post.asDictionary() else {return}
                    
                    // set dictionary data to collection
                    firestorePostRef.setData(dict) {
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        
                        // save dictionary to Collections
                        PostViewModel.timelineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                        
                        // allPosts/postId
                        PostViewModel.AllPosts.document(postId).setData(dict)
                        
                        onSuccess(post)
                    }
                }
            }
        }
    }
}

