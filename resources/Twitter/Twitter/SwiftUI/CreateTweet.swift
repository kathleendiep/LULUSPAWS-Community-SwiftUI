//
//  CreateTweet.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI
import Firebase

struct CreateTweet : View {
    @Binding var show : Bool
    @State var txt = ""

    var body : some View{

        VStack{
            
            HStack{
                
                Button(action: {
                        
                    self.show.toggle()
                    
                }) {
                    
                    Text("Cancel")
                }
                
                Spacer()
                
                Button(action: {
                    
                    
                    postTweet(msg: self.txt)
                    self.show.toggle()
                    
                }) {
                    
                    Text("Tweet").padding()
                    
                }.background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            multilineTextField(txt: $txt)
            
        }.padding()
    }
}
