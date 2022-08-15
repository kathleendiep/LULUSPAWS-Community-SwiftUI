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
            
           
        }.navigationTitle("User Search")
    }
}
