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
            
            Spacer()
            
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
                
                // icons
                HStack{
                    VStack{
                        Link(destination: URL(string: "www.twitter.com/\(user!.twitter)")!) {
                            Image("Twitter")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50.0, height: 50.0)
                        }
                    }.padding(.top, 4)
                    
                    VStack{
                        Link(destination: URL(string: "www.instagram.com/\(user!.instagram)")!) {
                            Image("Instagram")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50.0, height: 50.0)
                        }
                    }.padding(.top, 4)
                }
            }
            
            if user != nil {
                
                VStack{
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text("\(postsCount)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("POSTS".uppercased())
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                        }
                        Spacer()
                        
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
                    .padding()
                    .frame(width: 360)
                    .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    // Bio & location
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Located in".uppercased())
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                            Text("\(user!.location)")
                                .font(.system(size: 18, design: .rounded))
                        }
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Bio".uppercased())
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                            Text("\(user!.bio)")
                                .font(.system(size: 18, design: .rounded))
                        }
                        Spacer()
                        
                    }
                    .padding()
                    .frame(width: 360)
                    .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                }
            }
        }
    }
}
