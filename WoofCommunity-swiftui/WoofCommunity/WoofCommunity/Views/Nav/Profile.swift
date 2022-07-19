//
//  Profile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

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
    @State private var selection = 1
    
    var body: some View {
        
        ScrollView{
            VStack{
                ProfileHeader(user: self.session.session)
                Button(action: {}){
                    Text("Edit Profile")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }.padding(.horizontal)
                
                Text("Profile")
                
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {}){
            Image(systemName: "person.fill")
        }, trailing: Button(action: {
            self.session.logout()
        }){
            Image(systemName: "arrow.right.circle.fill")
            
        })
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

// edit profile https://www.youtube.com/watch?v=vV1lIG7VMX0&list=PLdBY1aYxSpPVI3wTlK1cKHNOoq4JA3X5-&index=25
