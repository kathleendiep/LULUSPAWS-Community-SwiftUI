//
//  Profile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

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
        VStack{
            ZStack{
                //background
                Color.white
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle( LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width:1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)
                
                Circle()
                    .frame(width: 300)
                    .foregroundColor(Color.blue.opacity(0.3))
                    .blur(radius: 10)
                    .offset(x: -100, y: -150)
                
                Circle()
                    .frame(width: 450)
                    .foregroundStyle(Color.pink.opacity(0.6))
                    .blur(radius: 20)
                    .offset(x: 200, y: -200)
                ScrollView{
                    VStack{
                        ProfileHeader(user: self.session.session, postsCount: profileViewModel.posts.count)
                        
                        NavigationLink(destination: EditProfile(session:self.session.session), isActive: $isLinkActive){
                            Button(action: {self.isLinkActive = true}){
                                Text("Edit Profile")
                                    .font(.title)
                                    .modifier(ButtonModifiers())
                                    .frame(width: 300)
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
        
    }
}





