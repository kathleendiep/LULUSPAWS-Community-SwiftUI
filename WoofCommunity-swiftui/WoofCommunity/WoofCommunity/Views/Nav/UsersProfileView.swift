//
//  UsersProfileView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UsersProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var selection = 0
    var user: User
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            
            VStack{
            ProfileHeader(user: user, postsCount: $profileViewModel.posts.count)
            // following: $profileViewModel.following, followers: $profileViewModel.followers
            
            HStack{
                FollowButton(user: user, followCheck: $profileViewModel.followCheck, followingCount: $profileViewModel.following, followersCount: $profileViewModel.followers)
            }.padding(.horizontal)
            
            if selection == 0 {
                LazyVGrid(columns: threeColumns) {
                    ForEach(self.profileViewModel.posts, id: \.postId ) {
                        (post) in
                        
                        
                        WebImage(url: URL(string: post.mediaUrl)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width/3, height:UIScreen.main.bounds.size.height/3, alignment: .center)
                            .clipped()
                        
                    }
                }
            }
            }.navigationBarTitle(Text(self.user.username))
            .onAppear{
                self.profileViewModel.loadUserPosts(userId: self.user.id!)
            }
        }
    }
}


