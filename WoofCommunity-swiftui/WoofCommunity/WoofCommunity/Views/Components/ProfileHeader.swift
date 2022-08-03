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
                
                HStack{
                    VStack(alignment: .leading) {
                        Text("\(postsCount)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Text("POSTS".uppercased())
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(user!.humanName)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Text("HOOMAN NAME".uppercased())
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(user!.petName)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Text("PET NAME".uppercased())
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                    Spacer()
                }
                // icons
                // if user has this field
                HStack{
                    VStack{
                        Link(destination: URL(string: "member.linkedIn")!) {
                            Image("LinkedIn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50.0, height: 50.0)
                        }
                    }.padding(.top, 60)
                    
                    VStack{
                        Link(destination: URL(string: "www.instagram.com")!) {
                            Image("Instagram")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50.0, height: 50.0)
                        }
                    }.padding(.top, 60)
                }
                
            }
        }
    }
}

//
//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        ProfileHeader()
//    }
//}

