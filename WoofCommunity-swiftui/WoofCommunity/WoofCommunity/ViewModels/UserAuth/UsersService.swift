//
//  UsersService.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/20/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class UsersService: ObservableObject {

    @Published var users: [User] = []
    @Published var isLoading = false
    
    // access the collection db = "users"
    // storeRoot = Firestore.firestore()
    static var Users = SignInViewModel.storeRoot.collection("users")
    
    // fetch id of collection
    static func UsersProfileId(userId: String) -> DocumentReference {
        return Users.document(userId)
    }
    
    // Fetch all users
    static func fetchUsers(onSuccess: @escaping(_ user: [User]) -> Void ) {
        
        // fetch id of users
//        UsersService.UsersProfileId(userId: userId).collection("users").getDocuments{ [self]
        SignInViewModel.storeRoot.collection("users").getDocuments{
            
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var users = [User]()
            
            for doc in snap.documents {
                let dict = doc.data()
                
                guard let decoder = try? User.init(fromDictionary: dict)
                else {
                    return
                }
                
                // will only show other users id
                if decoder.id != Auth.auth().currentUser?.uid {
                    users.append(decoder)
                }
                onSuccess(users)
            }
      
        }
    }
}

