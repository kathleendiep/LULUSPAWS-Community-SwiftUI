//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

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
    // append the user fetch here
    @State var users: [User] = []
    
    func loadAllUsers() {
        // fetchUser
        MainViewModel.fetchUser() {
            (users) in
            
            self.users = users
            
        }
    }
    
    var body: some View{
        ScrollView{
            Text("Woof Community 🦴🏡")
                .font(.headline)
            VStack {
                Text("Checkout some users! 🦴🏡")
                    .font(.headline)
                ForEach(self.users, id: \.id) {
                    (user) in
                    HStack{
                        WebImage(url: URL(string: user.profileImageUrl)!)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width:100,height:100, alignment: .leading)
                        
                        Text("\(user.username)")
                            .font(.caption)
                        Text("\(user.humanName) ||\(user.petName) ")
                            .font(.caption2)
                    }
                    // from components
//                    PostCardImage(post: post)
//                    PostCard(post: post)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear{
                self.loadAllUsers()
            }
        }
    }
//    init() {
//        postViewModel.getData()
//     }
    

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
