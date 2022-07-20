//
//  UserProfile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/19/22.
//

import Foundation
// Collection: Identifiable
struct UserProfile: Identifiable, Encodable {

    var id: String? // document type ID from db
//    var name: String
//    var petName: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String

    // MARK: - Location
    
//    - username
//    - name
//    - pet name
//    - humanProfilePic
//    - dogProfilepic
//    - email (but hidden)
//    - location 


}

