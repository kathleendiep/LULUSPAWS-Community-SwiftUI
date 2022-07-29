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
    @State private var isLinkActive = false
    var user: User?
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    func listen(){
        session.listen()
    }

    var body: some View {
        ScrollView{
            VStack{
                
                ProfileHeader(user: self.session.session, postsCount: profileViewModel.posts.count)
                
                
//                ProfileHeader(user: user, postsCount: $profileViewModel.posts.count, following: $profileViewModel.following, followers: $profileViewModel.followers)
//                
                VStack(alignment: .leading){
                    Text(session.session?.bio ?? "").font(.headline).lineLimit(1)
                }
            
                NavigationLink(destination: EditProfile(session:self.session.session), isActive: $isLinkActive){
                    Button(action: {self.isLinkActive = true}){
                        Text("Edit Profile")
                            .font(.title)
                            .modifier(ButtonModifiers())
                    }.padding(.horizontal)
                }
                if selection == 0 {
                LazyVGrid(columns: threeColumns) {
                ForEach(self.profileViewModel.posts, id: \.postId ) {
                    (post) in

                    // Link to a different page based on user session
                    // gets the post and user
                    NavigationLink(destination: UserPostCardView(post: post, user: self.session.session!)) {
                        // enter the view
                    WebImage(url: URL(string: post.mediaUrl)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width/3, height:UIScreen.main.bounds.size.height/3, alignment: .center)
                        .clipped()
                    }
                }
                }
                
                } else if (self.session.session == nil) {Text("")}
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {}){
                    
                    NavigationLink(destination: UserProfile()){
                        Image(systemName: "person.fill")
                    }
 
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
