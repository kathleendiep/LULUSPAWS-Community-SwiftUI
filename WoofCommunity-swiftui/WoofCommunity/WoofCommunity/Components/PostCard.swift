//
//  PostCard.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import SwiftUI

struct PostCard: View {
    
    @ObservedObject var postCardViewModel = PostCardViewModel()
    
    @State private var animate = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat {
        postCardViewModel.isLiked ? 0.5 : 2.0
    }
    
    init(post: Post) {
        self.postCardViewModel.post = post
        self.postCardViewModel.hasLikedPost()
    }
    
    var body: some View {
       
        VStack(alignment: .leading){
            
            HStack(spacing:15){
                // check if isLiked
                Button(action: {}) {
                        Image(systemName: (self.postCardViewModel.isLiked) ? "heart.fill" : "heart")
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor((self.postCardViewModel.isLiked) ? .red :  .black )
                    }
            }
        }
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard()
    }
}
