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
import Combine
import FirebaseFirestoreSwift

// took this out NSObject,
class SignInViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    @Published var signedIn = false
    static let auth = Auth.auth()
    static var storeRoot = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
//    init(user: User = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")) {
//    self.user = user
//  }
//    init(user: User = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")) {
//    self.user = user
//
//    self.$user
//      .dropFirst()
//      .sink { [weak self] user in
//        self?.modified = true
//      }
//      .store(in: &self.cancellables)
//  }
    
    
    static var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    // goes to Firestore db
    static func getUserId(_ userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
//    func getData() {
//    
//        storeRoot.collection("users").getDocuments { snapshot, error in
//    
//                // Check for errors
//                if error == nil {
//                    // No errors
//    
//                    if let snapshot = snapshot {
//    
//                        // Update the SOT property in main UI
//                        DispatchQueue.main.async {
//    
//                            // Assign to self.users SOT
//                            // Get all the documents in the collection array, and create User
//                            self.users = snapshot.documents.map{ d in
//    
//                                // Create a User item for each document
//                                return User(id: d.documentID, email: d["email"] as? String ?? "" , profileImageUrl: d["profileImageUrl"] as? String ?? "" , username: d["username"] as! String, bio: d[""] as! String)
//                            }
//                        }
//                    }
//                    else {
//                        // Handle the error
//                    }
//                }
//            }
//        }
//        
//    
//    static func signIn(email: String, password: String) {
//        auth.signIn(withEmail: email,
//                    password: password) { [weak self] result, error in
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
//
    static func signIn(email:String, password:String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else {return}
            
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
//
//    static func signOut() {
//        try? auth.signOut()
//
//        self.signedIn = false
//    }
}


