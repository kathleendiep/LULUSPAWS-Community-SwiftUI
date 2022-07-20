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

class UsersService: ObservableObject{

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
    func fetchUsers(userId: String, onSuccess: @escaping(_ users: [User]) -> Void ) {
        
        // fetch id of users
        UsersService.UsersProfileId(userId: userId).collection("users").getDocuments{ [self]
            (snapshot, error) in
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
//            var users = [User]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? User.init(fromDictionary: dict)
                else {
                    return
                }
                
                // adds to users array
                self.users.append(decoder)
                
            }
            onSuccess(self.users)
        }
    }
    
    // load all users
    func getAllUsers() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snapshot, error) in
            
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            // Update the SOT property in main UI
            DispatchQueue.main.async {
                
//                var users = [User]()
                for doc in snap.documents {
                    let dict = doc.data()
                    guard let decoder = try? User.init(fromDictionary: dict)
                    else {
                        return
                    }
                    
                    // adds to users array
                    self.users.append(decoder)
                    
                }
            }
        }
    }
}


