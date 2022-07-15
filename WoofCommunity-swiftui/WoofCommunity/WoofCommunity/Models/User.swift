//
//  User.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import Foundation

// Collection: Identifiable
struct User: Identifiable, Encodable {
    
    var id: String? // document type ID from db
    
    // label: type
    // set the value in the DB
    var name: String
    var petName: String
    
    
//    var email: String
//    var userName: String
//    var bio: String
    // how do i connect a user to a post?
    
    // MARK: - Location

}

