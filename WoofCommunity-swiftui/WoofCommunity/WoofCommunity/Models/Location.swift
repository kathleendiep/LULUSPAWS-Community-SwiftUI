//
//  Location.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/26/22.
//

import Foundation
import CoreLocation

struct Location: Codable {
    
    let latitude: Double
    let longitude: Double
    var coordinates: CLLocationCoordinate2D{
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

