//
//  User.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import Foundation

struct User: Identifiable, Encodable, Decodable {
    
    var id: String?
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    var searchName: [String]
    var petName: String
    var humanName: String
    var profileDogImageUrl: String
    var location: String
    var twitter: String
    var instagram: String

}




