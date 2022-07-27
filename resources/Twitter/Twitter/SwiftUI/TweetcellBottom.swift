//
//  TweetcellBottom.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI


struct tweetCellBottom : View {
    
    var body : some View{
        
        HStack(spacing : 40){
            
            Button(action: {
                
            }) {
                
                Image("Comments").resizable().frame(width: 20, height: 20)
                
            }.foregroundColor(.gray)
            
            Button(action: {
                
            }) {
                
                Image("Retweet").resizable().frame(width: 20, height: 20)
                
            }.foregroundColor(.gray)
            
            Button(action: {
                
            }) {
                
                Image("love").resizable().frame(width: 20, height: 17)
                
            }.foregroundColor(.gray)
            
            Button(action: {
                
            }) {
                
                Image("upload").resizable().frame(width: 20, height: 20)
                
            }.foregroundColor(.gray)
        }
    }
}
