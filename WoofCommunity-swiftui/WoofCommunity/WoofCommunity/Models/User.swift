//
//  User.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import Foundation
/*
- create Views
- create ViewModel
 - create Utilities - Storage
    - adding photo, email, username
 
 */

// Collection: Identifiable
struct User: Identifiable, Encodable, Decodable {
    
    // label: type
    // set the value in the DB
    var id: String? // document type ID from db
//    var name: String
//    var petName: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String

    // MARK: - Location

}




