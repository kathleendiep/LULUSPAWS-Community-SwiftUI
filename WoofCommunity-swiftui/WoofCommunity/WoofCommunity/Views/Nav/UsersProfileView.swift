//
//  UsersProfileView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/28/22.
//

import SwiftUI

struct UsersProfileView: View {
    
    var user: User
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    
    var body: some View {
        
        // to do at 15:53
    
    // https://www.youtube.com/watch?v=dURZ1kOpl7o&list=PLdBY1aYxSpPVI3wTlK1cKHNOoq4JA3X5-&index=22
        ProfileHeader(user: self.session.session, postsCount: profileViewModel.posts.count)
        
        
        
    }
}

struct UsersProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UsersProfileView()
    }
}
