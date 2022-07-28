//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI
import Firebase

struct Main: View {
    var body: some View {
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
    @State var posts: [Post] = []
    
    func loadAllUsers() {
        // fetchUser
        MainViewModel.fetchUser() {
            
            (users) in
            
            self.users = users
            
        }
    }

    func getAllPosts() {
        let db = Firestore.firestore()
        
        db.collection("allPosts").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print(" these are the posts \(document.documentID): \(document.data())")
                    
//                    self.posts.append(document.data())
                    
                    let dict = document.data()

                    guard let decoder = try? Post.init(fromDictionary: dict) else {return}

                    self.posts.append(decoder)
                   
                }
            }
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
                }
                
                Text("This is the posts")
                ForEach(self.posts, id: \.id) {
                    (post) in
                    HStack{
                        Text("This is the posts")
                        Text("\(post.caption)")
                            .font(.caption)
                        PostCardImage(post: post)
                        PostCard(post: post)
                    }
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear{
                
//                self.loadAllPosts()
                self.loadAllUsers()
                
            }
        }
    }
    init() {
        getAllPosts()
        
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
