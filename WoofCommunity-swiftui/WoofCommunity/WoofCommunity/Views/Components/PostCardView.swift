//
//  PostCardView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import SwiftUI

struct UserPostCardView: View {
    
    var post: Post
    var user: User
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var presentActionSheet = false
    
    
    func handleDeleteTapped() {
        profileViewModel.deletePost(userId: user.id!)
    }
    
    var body: some View {
        VStack {
        Section {
            PostCardImage(post: post)
            PostCard(post: post)
            
             Button("Delete Post") { self.presentActionSheet.toggle() }
                 .foregroundColor(.red)
             }
        }
    }
}
