//
//  UserProfile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/27/22.
//

import SwiftUI

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
            VStack{
                
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
                            Text("\(user.email)")
                        }
                    }
                    
                }
                
            }
        }.navigationTitle("User Search")
    }
}

