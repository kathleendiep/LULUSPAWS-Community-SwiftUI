//
//  Profile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI
import
/*
 USERPROFILE MODEL:
 
 //    - username
 //    - name
 //    - pet name
 //    - humanProfilePic
 //    - dogProfilepic
 //    - email (but hidden)
 //    - location
 
 
 */
struct Profile: View {
    
    // MARK: - Properties
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack{
            Text("Profile")
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {}) {
            Image(systemName: "arrow.right.circle.fill")
        })
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

