//
//  ContentView.swift
//  Twitter
//
//  Created by Kavsoft on 24/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//
//import google info.plist to avoid errors

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        
        
        ZStack{
            
            TabView{
                
                Home().tabItem {
                    
                    Image("Home")
                    
                }.tag(0)
                
                Search().tabItem {
                    
                    Image("Search")
                    
                }.tag(1)
                
                Text("Notifications").tabItem {
                    
                    Image("Notifications")
                    
                }.tag(2)
                
                Text("Messages").tabItem {
                    
                    Image("Messages")
                    
                }.tag(3)
                
            }.accentColor(.blue)
            .edgesIgnoringSafeArea(.top)
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Image("Tweet").resizable().frame(width: 20, height: 20).padding()
                    }.background(Color("bg"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    
                }.padding()
                
            }.padding(.bottom,65)

        }.sheet(isPresented: $show) {
            
            CreateTweet(show: self.$show)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// its not showing selected image tint color I dont know is Xcode bug or not.....
// In last session we did Tweets View
// now were going to create a Tweet and display it in Tweets View.....

// since i'm using same user name and id its showing username as kavsoft.....

// now were going to create top Hastags View....

// time to clean code.....
