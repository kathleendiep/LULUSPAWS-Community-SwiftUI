//
//  Post.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/20/22.
//

import Foundation
import SwiftUI

struct Post: Identifiable, Encodable, Decodable {
    
    var id: String? // document type ID from db
    var caption: String
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String
    var date: Double
    var likes: [String: Bool]
    var likeCount: Int
    
}
