//
//  ProfileHeader.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/19/22.

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {
    
    var user: User?
    var postsCount: Int

    var body: some View {
        VStack {
            if user != nil {
                WebImage(url: URL(string: user!.profileImageUrl)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width:100,height:100, alignment: .leading)
            } else {
                Color.init(red: 0.9, green: 0.9, blue: 0.9).frame(width: 100, height: 100, alignment: .trailing)
                    .padding(.leading)
            }
       
            if user != nil {
                Text(user!.username).font(.headline).bold().padding(.leading)
            }
        }
        
        if user != nil {
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("Posts").font(.footnote)
                    Text("\(postsCount)").font(.title).bold()
                }.padding(.top, 60)
                
                Spacer()
                VStack{
                    Text("name").font(.footnote)
                    Text("\(user!.humanName)").font(.title).bold()
                }.padding(.top, 60)
                Spacer()
                VStack{
                    Text("Woof, I'm").font(.footnote)
                    Text("\(user!.petName)").font(.title).bold()
                    
                }.padding(.top, 60)
                Spacer()
            }
        }
        }
    }
}

