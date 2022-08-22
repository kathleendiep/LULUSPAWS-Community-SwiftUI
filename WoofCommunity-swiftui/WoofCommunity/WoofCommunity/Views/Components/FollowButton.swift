//
//  FollowButton.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import SwiftUI

struct FollowButton: View {
    
    @ObservedObject var followViewModel = FollowViewModel()
    
    var user: User
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @Binding var followCheck: Bool
    
    init(user: User, followCheck: Binding<Bool>, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        
        self.user = user
        self._followCheck = followCheck
        self._followingCount = followingCount
        self._followersCount = followersCount
        
    }
    
    func follow() {
        if !self.followCheck {
            followViewModel.follow(userId: user.id!, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            self.followCheck = true
        } else {
            
            followViewModel.unfollow(userId: user.id!, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            self.followCheck = false
        }
    }

    var body: some View {
        Button(action: follow){
            Text((self.followCheck) ? "Unfollow" : "Follow" ).modifier(ButtonModifiers())
        }
    }
}
