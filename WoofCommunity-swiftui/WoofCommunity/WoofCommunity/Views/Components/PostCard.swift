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
                Button(action: {
                    self.animate = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.duration, execute: {
                        self.animate = false
                        
                        if(self.postCardViewModel.isLiked) {
                            self.postCardViewModel.unlike()
                        } else {
                            self.postCardViewModel.like()
                        }
                    })
                    
                }) {
                        Image(systemName: (self.postCardViewModel.isLiked) ? "heart.fill" : "heart")
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor((self.postCardViewModel.isLiked) ? .red :  .black )
                }.padding().scaleEffect(animate ? animationScale : 1)
                    .animation(.easeIn(duration: duration))
                    
                Image(systemName: "bubble.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                
                Spacer()
                
            }.padding(.leading, 16)
            
            // display like count
            if(self.postCardViewModel.post.likeCount > 0) {
                Text("\(self.postCardViewModel.post.likeCount) likes")
            }
            
            Text("View Comments").font(.caption).padding(.leading)
            
            
        }
    }
}
//
//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}
