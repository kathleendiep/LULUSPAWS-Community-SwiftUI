//
//  User.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import Foundation
import CoreLocation
/*
- create Views
- create ViewModel
 - create Utilities - Storage
    - adding photo, email, username
 
 */

// Collection: Identifiable
struct User: Identifiable, Encodable, Decodable {
    
    var id: String? // document type ID from db
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    
    // to do: Add more fields
//    var petName: String
//    var humanName: String
//    var profileDogImageUrl: String
//    var location: CLLocationCoordinate2D
    /*
    let exampleLocation = CLLocation(latitude: longitude:)
     
     */


    // MARK: - Location

}




