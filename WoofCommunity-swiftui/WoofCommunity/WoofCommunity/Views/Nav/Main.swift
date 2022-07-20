//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth

struct Main: View {
    
    @ObservedObject var signInVM = SignInViewModel()
    
    var body: some View {
        ScrollView{
            Text("check out some furiends")
                .font(.subheadline)
            List {
                Section("My Entries") {
                    // if it has users
                    ForEach(signInVM.users) {
                        user in
//                        print(user)
                        Text("users go here")
                        Text(user.email)
                        Text(user.username)
                            .fontWeight(.bold)
                        Text(user.bio)
                    }
                    
                }
            }
        }
        .navigationTitle("Woof Community 🦴🏡")

    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        //        let user = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")
        Main()
    }
}


/*
 
 
 //    private func userRowView(user: User) -> some View {
 //        NavigationLink(destination: UserDetailView(user: user)) {
 //            VStack(alignment: .leading) {
 //                HStack {
 //                    VStack(alignment: .leading) {
 //                        Text(user.username)
 //                            .fontWeight(.bold)
 //                        Text(user.bio)
 //                    }
 //                }
 //            }
 //        }
 //    }
 
 */
