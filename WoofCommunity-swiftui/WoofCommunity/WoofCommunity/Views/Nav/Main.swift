//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth

struct Main: View {
    @EnvironmentObject var session: SessionStore
    @StateObject var profileViewModel = ProfileViewModel()
    @ObservedObject var postCardViewModel = PostCardViewModel()
    @ObservedObject var signInVM = SignInViewModel()
    
    var body: some View {
        ScrollView{
            Text("Woof Community 🦴🏡")
                .font(.subheadline)
            
            VStack {
                
                // get Users posts
                ForEach(self.profileViewModel.posts, id: \.postId ) {
                    (post) in
                    
                    // from components
                    PostCardImage(post: post)
                    PostCard(post: post)
                    
                    
                }
            }
            // only for profile users
//            List {
//                Section("My Entries") {
//                    ForEach(signInVM.users) {
//                        user in
//                        Text("users go here")
//                        Text(user.email)
//                        Text(user.username)
//                            .fontWeight(.bold)
//                        Text(user.bio)
//                    }
//
//                }
//            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear{
            self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            }
//        .navigationTitle("Woof Community 🦴🏡")
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        //        let user = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")
        Main()
    }
}


/*
 
 
 //    private func userRowView(user: User) -> some View {
 //        NavigationLink(destination: UserDetailView(user: user)) {
 //            VStack(alignment: .leading) {
 //                HStack {
 //                    VStack(alignment: .leading) {
 //                        Text(user.username)
 //                            .fontWeight(.bold)
 //                        Text(user.bio)
 //                    }
 //                }
 //            }
 //        }
 //    }
 
 */
