//
//  SearchViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/27/22.

import Foundation
import FirebaseAuth

class SearchViewModel {

    // fetch all the users
    static func searchUser(input: String, onSuccess: @escaping (_ user: [User]) -> Void) {
        
        // access users with our removeWhiteSpace extension
        SignInViewModel.storeRoot.collection("users").whereField("searchName", arrayContains: input.lowercased().removeWhiteSpace()).getDocuments {
            
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
            var users = [User]()
            
            for document in snap.documents {
                let dict = document.data()
                
                guard let decoded = try? User.init(fromDictionary: dict) else {return}
                
                // will only show other users id
                if decoded.id != Auth.auth().currentUser?.uid {
                    users.append(decoded)
                }
                
                onSuccess(users)
                
            }
        }
    }
}
