//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth

struct Main: View {
    var body: some View {
        Text("Main")
        MainFeed()
    }
}

struct MainFeed : View {
    
    // MARK: - Properties
    @EnvironmentObject var session: SessionStore
    @ObservedObject var postCardViewModel = PostCardViewModel()
    @ObservedObject var postViewModel = PostViewModel()
    @StateObject var mainViewModel = MainViewModel()
//    @ObservedObject var signInVM = SignInViewModel()
//    @StateObject var profileViewModel = ProfileViewModel()
    
    
    var body: some View{
        ScrollView{
            Text("Woof Community 🦴🏡")
                .font(.subheadline)
            
            VStack {
                
                // get Users posts
                ForEach(self.mainViewModel.allPosts, id: \.postId) {
                    (post) in
                    
                    // from components
                    PostCardImage(post: post)
                    PostCard(post: post)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
//            .onAppear{
//                self.mainViewModel.getAllPosts(userId: self.mainViewModel.allPosts.userId)
//            }
        }
    }
}

//
//
//@EnvironmentObject var session: SessionStore
//@StateObject var profileViewModel = ProfileViewModel()
//@ObservedObject var postCardViewModel = PostCardViewModel()
//@ObservedObject var signInVM = SignInViewModel()
//
//var body: some View {
// MARK: - This is for the feed
//    ScrollView{
//        Text("Woof Community 🦴🏡")
//            .font(.subheadline)
//
//        VStack {
//
//            // get Users posts
//            ForEach(self.profileViewModel.posts, id: \.postId ) {
//                (post) in
//
//                // from components
//                PostCardImage(post: post)
//                PostCard(post: post)
//
//
//            }
//        }
//        // only for profile users
////            List {
////                Section("My Entries") {
////                    ForEach(signInVM.users) {
////                        user in
////                        Text("users go here")
////                        Text(user.email)
////                        Text(user.username)
////                            .fontWeight(.bold)
////                        Text(user.bio)
////                    }
////
////                }
////            }
//    }
//    .navigationTitle("")
//    .navigationBarHidden(true)
//    .onAppear{
//        self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
//        }
////        .navigationTitle("Woof Community 🦴🏡")
//}
