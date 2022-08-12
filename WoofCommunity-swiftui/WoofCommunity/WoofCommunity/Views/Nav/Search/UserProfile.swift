//
//  UserProfile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    func searchUsers(){
        isLoading = true
        
        SearchViewModel.searchUser(input: value) {
            (users) in
            
            self.isLoading = false
            self.users = users
        }
    }
    
    var body: some View {
        ScrollView{
            
            ZStack {
                LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)

                Circle()
                    .frame(width: 300)
                    .foregroundColor(Color.blue.opacity(0.3))
                    .blur(radius: 10)
                    .offset(x: -100, y: -150)

                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .frame(width: 500, height: 500)
                    .foregroundStyle(LinearGradient(colors: [Color.purple.opacity(0.6), Color.mint.opacity(0.5)], startPoint: .top, endPoint: .leading))
                    .offset(x: 300)
                    .blur(radius: 30)
                    .rotationEffect(.degrees(30))

                Circle()
                    .frame(width: 450)
                    .foregroundStyle(Color.pink.opacity(0.6))
                    .blur(radius: 20)
                    .offset(x: 200, y: -200)
                
              
                VStack(){
                    
                    
                    // everytime value changes, make sure to search users
                    SearchBar(value: $value).padding()
                        .onChange(of: value, perform: {
                            new in
                            
                            searchUsers()
                            
                        })
                    
                    if !isLoading {
                        
                        ForEach(users, id: \.id){
                            
                            user in
                            
                            
                            
                            HStack{
                                VStack(alignment: .leading) {
                                    NavigationLink {
                                        UsersProfileView(user: user)
                                    } label: {
                                        WebImage(url: URL(string: user.profileImageUrl)!)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width:100,height:100, alignment: .leading)
                                        
                                        VStack {
                                        Text("\(user.username)")
                                            .font(.caption)
                                        Text("\(user.humanName) ||\(user.petName) ")
                                            .font(.caption2)
                                        }
                                    }
                                }
                            }
                            Divider().background(Color.black)
                        }
                        
                    }
                    
                  
                }
                .frame(width: 400, alignment: .center)
            }
         
           
        }.navigationTitle("User Search")
    }
}
