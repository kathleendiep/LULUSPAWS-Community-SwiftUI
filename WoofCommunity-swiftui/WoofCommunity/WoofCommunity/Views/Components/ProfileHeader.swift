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
    // to do: add in userProfile fields
    
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
//            Text(user?.username ?? "").font(.headline).bold().padding(.leading)
            Text(user!.username).font(.headline).bold().padding(.leading)
        }
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("Posts").font(.footnote)
                    Text("\(postsCount)").font(.title).bold()
                }.padding(.top, 60)
                
                Spacer()
                VStack{
                    Text("Human Name").font(.footnote)
                    Text("20").font(.title).bold()
                }.padding(.top, 60)
                Spacer()
                VStack{
                    Text("Dog Name").font(.footnote)
                    Text("20").font(.title).bold()
                }.padding(.top, 60)
                Spacer()
            }
        }
    }
}

