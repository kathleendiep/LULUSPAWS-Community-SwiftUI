//
//  Profile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

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
    @StateObject var profileViewModel = ProfileViewModel()
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    
    //todo: picker in #11
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeader(user: self.session.session)
                Button(action: {}){
                    Text("Edit Profile")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }.padding(.horizontal)
                
                LazyVGrid(columns: threeColumns) {
                    ForEach(self.profileViewModel.posts, id: \.postId) {
                        (post) in
                        
                        WebImage(url: URL(string: post.mediaUrl)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/3)
                        
                    }
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
        .onAppear{
            self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            }
        }
    }
}
//
//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}

