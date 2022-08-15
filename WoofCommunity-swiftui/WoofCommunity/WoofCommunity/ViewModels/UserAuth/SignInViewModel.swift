//
//  SignInViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift

class SignInViewModel: NSObject, ObservableObject {

    // MARK: - Properties
    @Published var signedIn = false
    @Published var users = [User]()
    
    static let auth = Auth.auth()
    static var storeRoot = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    static var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    // goes to Firestore db
    static func getUserId(_ userId: String) -> DocumentReference {
        // Firestore.firestore().collection("users).document(userId)
        return storeRoot.collection("users").document(userId)
    }
    
    static func signIn(email:String, password:String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else {return}
            
            // adds in data to db
            let firestoreUserId = getUserId(userId)
            
            firestoreUserId.getDocument{
                (document, error) in
                
                if let dict = document?.data() {
                    
                    guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
                    
                    onSuccess(decodedUser)
                }
            }
        }
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
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
}


