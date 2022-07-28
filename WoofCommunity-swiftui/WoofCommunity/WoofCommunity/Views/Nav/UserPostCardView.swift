//
//  PostCardView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import SwiftUI

struct UserPostCardView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var presentActionSheet = false
    var post: Post
    var user: User
    
    
//    init(session: User?){
//        _bio = State(initialValue:session?.bio ?? "")
//        _username = State(initialValue: session?.username ?? "" )
//    }
    
    func handleDeleteTapped() {
        profileViewModel.deletePost(userId: user.id!)
    }
    
    var body: some View {
        VStack {
        Section {
            PostCardImage(post: post)
            PostCard(post: post)
            
            Button("Delete Post") { self.handleDeleteTapped() }
                 .foregroundColor(.red)
             }
        }
    }
}
