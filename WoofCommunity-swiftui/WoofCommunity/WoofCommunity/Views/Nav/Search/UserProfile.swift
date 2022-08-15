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
                        
                            ProfileSummaryCard(users: users)
                            Divider().background(Color.black)
                        

                    }
                    
                  
                }
                .frame(width: 400, alignment: .center)
            
           
        }.navigationTitle("User Search")
    }
}


struct ProfileSummaryCard: View {
    
//    @State private var value: String = ""
    @State var users: [User] = []
//    @State var isLoading = false
    
    
    var body: some View {
        
        VStack{

            ForEach(users, id: \.id) {
                
                (user) in
                
                NavigationLink {
                    UsersProfileView(user: user)
                } label: {
                    HStack{
                        VStack(spacing: 50){
                            HStack {
                                VStack(alignment: .center) {
                                    WebImage(url: URL(string: user.profileImageUrl)!)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width:100,height:100, alignment: .leading)
                                }
                                VStack(alignment: .leading) {
                                    Text("\(user.humanName)")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    Text("@\(user.username)".uppercased())
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("\(user.petName)")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    Text("is my pet".uppercased())
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
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

    }
}

