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
                    
                    let dict = document.data()
                    
                    guard let decoder = try? Post.init(fromDictionary: dict) else {return}
                    
                    self.posts.append(decoder)
                    
                }
            }
        }
    }
    
    var body: some View{
        
        ScrollView{
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6759886742, green: 0.9469802976, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack{
                    ZStack {
                        
                        Circle()
                            .frame(width: 400, height: 400)
                            .offset(x: 150, y: -200)
                            .foregroundColor(Color.purple.opacity(0.6))
                            .blur(radius: 8)
                        Circle()
                            .frame(width: 300, height: 300)
                            .offset(x: -100, y: -125)
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.4))
                            .blur(radius: 8)
                        
                        PopupView()
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Checkout some users")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .padding(.top, 5)
                    }

                    VStack {
                        Text("Checkout some users!")
                            .font(.headline)
                        ForEach(self.users, id: \.id) {
                            (user) in
                            
                            NavigationLink {
                                UsersProfileView(user: user)
                            } label: {
                            HStack{
                                WebImage(url: URL(string: user.profileImageUrl)!)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width:100,height:100, alignment: .leading)
                                
                                Text("\(user.username)")
                                    .font(.caption)
                                Text("My name is \(user.humanName)")
                                    .font(.subheadline)
                                Text("\(user.petName) ")
                                    .font(.caption2)
                            }
                            }
                            Divider().background(Color.gray)
                        }
                    }
                    
                    
                    
                }
                
                .edgesIgnoringSafeArea(.all)

            }
           
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear{
            self.loadAllUsers()
        }
    }
//
//    init() {
//        getAllPosts()
//
//    }
}

struct PopupView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.5)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
                .padding()
               
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Woof Community 🦴🏡")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    
                
                Text("check out our pupventures with some furry cute friends")
                    .font(.footnote)
                
            }
            .padding()
            .frame(width: 300, height: 200)
            .foregroundColor(Color.black.opacity(0.8))
        }
        
    }
}

