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
    @Published var user: User
    @Published var modified = false
    
    private let db = Firestore.firestore()

    private var cancellables = Set<AnyCancellable>()
     
    init(user: User = User(id: "", name: "", petName: "")) {
    self.user = user
     
    self.$user
      .dropFirst()
      .sink { [weak self] user in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
    
    
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

    func updateData(_ user: User) {
       if let documentId = user.id {
         do {
           try db.collection("users").document(documentId).setData(from: user)
         }
         catch {
           print(error)
         }
       }
     }
    
    
   func updateOrAdd() {
       if let _ = user.id {
           self.updateData(self.user)
     }
     else {
         addData(name: user.name, petName: user.petName)
     }
   }
    
    func handleDoneTapped() {
      self.updateOrAdd()
    }
    
    func deleteData(userToDelete: User) {
        
        // Specify the document to delete
        if let documentId = userToDelete.id {
            db.collection("users").document(documentId).delete { error in
                
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
}

// MARK: FIREBASE NOTES
/*
 
 FirebaseFirestore - access to Firestore API
 Combine - declarative APIs for Swift
 FirebaseFirestoreSwift adds some cool functionalities to help you integrate Firestore with your models. It lets you convert Cards into documents and documents into Cards.
 
 */


