//
//  SignInViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//
import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignInViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    let auth = Auth.auth()
    static var storeRoot = Firestore.firestore()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    // goes to Firestore db
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        auth.createUser(withEmail: email, password: password) {
            ( authData, error ) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            guard let userId = authData?.user.uid else {return}
            
            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            // Add to save Profile - Services
            StorageService.saveProfileImage(userId: userId, username: username, email: email, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError )
        }
    }

//    func signUp(email: String, password: String) {
//        auth.createUser(withEmail: email, password: password) { [weak self]
//            result, error in
//            guard result != nil, error == nil else {
//                return
//            }
//            // Success
//            DispatchQueue.main.async {
//                // Success
//                self?.signedIn = true
//            }
//        }
//    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}


