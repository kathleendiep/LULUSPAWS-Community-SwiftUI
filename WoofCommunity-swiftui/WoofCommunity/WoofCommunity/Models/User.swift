//
//  User.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import Foundation
import CoreLocation

/*
 TODO:
 - go on iphone and see if it locates
 
 - longitude, latitude
 - updatedMap within certain radius
 
 Option
 - corelocation - accessing from phone
 - db of zipcodes with longitude/latitude

 
 - handle app settings
 
 */

/*
- create Views
- create ViewModel
- create Utilities - Storage
 - adding photo, email, username
 
 */


struct User: Identifiable, Encodable, Decodable {
    
    var id: String? // document type ID from db
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    var searchName: [String]
   
    var petName: String
    var humanName: String
//    var profileDogImageUrl: String
//    var location: Location
    
    
    // MARK: - Location
    // automatically find

    
    // todo: funfacts
    
//    var location: CLLocationCoordinate2D
    /*
    let exampleLocation = CLLocation(latitude: longitude:)
     
     */
}




