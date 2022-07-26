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
    @State private var selection = 0
    @StateObject var profileViewModel = ProfileViewModel()
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    func listen(){
        session.listen()
    }
    
    //todo: picker in #11
    //todo: add in #14 - a scrollview
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeader(user: self.session.session)
                Button(action: {}){
                    Text("Edit Profile")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }.padding(.horizontal)
                
                Text("This is the PostCardImage in a Lazy V Grid")
                
                if selection == 0 {
                LazyVGrid(columns: threeColumns) {
                    ForEach(self.profileViewModel.posts, id: \.postId ) {
                        (post) in
                        Text("Image goes here: \(post.caption) \(post.username)")
                        WebImage(url: URL(string: post.mediaUrl)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: .center)
                            .clipped()
                        
                    }
                }
                } else
                if (self.session.session == nil) {Text("")}
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


//
//Text("This is the feed")
//ScrollView{
//    VStack {
//
//        // get Users posts
//        ForEach(self.profileViewModel.posts, id: \.postId ) {
//            (post) in
//
//            // from components
//            PostCardImage(post: post)
//            PostCard(post: post)
//
//
//        }
//    }
//}
