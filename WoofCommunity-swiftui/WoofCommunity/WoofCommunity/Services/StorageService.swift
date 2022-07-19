//
//  Storage.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/14/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

// adds to storage
class StorageService {

    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference(forURL: "gs://woofcommunity-45000.appspot.com/profile")
    
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileId(userId:String) -> StorageReference {
        return storageProfile.child(userId)
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
                    
                    // check if user is logged iin
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
                    let user = User.init(id: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "")
                    
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
}

