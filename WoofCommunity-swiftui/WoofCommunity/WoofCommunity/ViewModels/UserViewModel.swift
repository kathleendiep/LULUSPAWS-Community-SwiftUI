//
//  UserViewModel.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/12/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift


class UserViewModel: ObservableObject {
    
    // MARK: - SOT
    @Published var users = [User]()
    private let db = Firestore.firestore()
    private let user = "users"
    // MARK: - CRUD
    /*
     - reference to db
     - specify the document to CRUD
     - check for errors
     - dispatchqueue to get UI to update
     */
    
    func addData(name: String, petName: String) {
        
        // addDocument to a collection
        db.collection("users").addDocument(data: ["name":name, "petName":petName]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call the data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the errors
            }
        }
    }
    
    func getData() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the SOT property in main UI
                    DispatchQueue.main.async {
                        
                        // Assign to self.users SOT
                        // Get all the documents in the collection array, and create User
                        self.users = snapshot.documents.map{ d in
                            
                            // Create a User item for each document
                            return User(id: d.documentID,
                                        name: d["name"] as? String ?? "" ,
                                        petName: d["petName"] as? String ?? "" )
                        }
                    }
                }
                else {
                    // Handle the error
                }
            }
        }
    }
//
//    func updateData(_ user: User) {
//
//       if let UserId = user.id {
//         do {
//           try db.collection("users").document(UserId).setData(from: user)
//         }
//         catch {
//           print(error)
//         }
//       }
//     }
    
    func updateData(_ user: User,_ name: String,_ petName: String) {
        
        guard let userID = user.id else { return }
        
        db.collection("users").document(userID).setData(["name": name, "petName": petName])
       
    }


//    func updateData(_ userToUpdate: User) {
//
//        let db = Firestore.firestore()
//
//        if let userID = userToUpdate.id {
//            do {
//                try db.collection("users").document(userID).setData( from: userToUpdate)
//            } catch {
//                fatalError("Unable to update card: \(error.localizedDescription).")
//            }
//        }
//
//    }
//
   
    
    
//
//    func updateData(_ user: User) {
//        let db = Firestore.firestore()
//
//        do {
//            try db.collection("users").document(user.id).setData(user)
//        } catch {
//            fatalError("Unable to update")
//        }
//    }
//
   
    func deleteData(userToDelete: User) {
        guard let deleteUser = userToDelete.id else { return }
        
        // Specify the document to delete
        db.collection("users").document(deleteUser).delete { error in
            
            // Check for errors
            if error == nil {
                
                // Update UI from main thread
                DispatchQueue.main.async {
                    
                    // Remove the user
                    self.users.removeAll { user in
                        // Check for the user to remove
                        return user.id == userToDelete.id
                    }
                }
            }
        }
    }
}
// MARK: FIREBASE NOTES
/*
 
 FirebaseFirestore - access to Firestore API
 Combine - declarative APIs for Swift
 FirebaseFirestoreSwift adds some cool functionalities to help you integrate Firestore with your models. It lets you convert Cards into documents and documents into Cards.
 
 */

