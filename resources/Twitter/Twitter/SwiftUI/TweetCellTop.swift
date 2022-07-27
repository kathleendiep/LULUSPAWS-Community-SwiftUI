//
//  TweetCellTop.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct tweetCellTop : View {
    
    var name = ""
    var id = ""
    var pic = ""
    var image = ""
    var msg = ""
    
    var body : some View{
        
        HStack(alignment: .top){
            
            VStack{
                
                AnimatedImage(url: URL(string: image)!).resizable().frame(width: 50, height: 50).clipShape(Circle())

            }

            
            VStack(alignment: .leading){
                
                Text(name).fontWeight(.heavy)
                Text(id)
                Text(msg).padding(.top, 8)
                
            }
            
        }.padding()
    }
}
