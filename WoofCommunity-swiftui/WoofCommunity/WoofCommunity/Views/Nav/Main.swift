//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth

struct Main: View {

    @ObservedObject var usersService = UsersService()
//    var user: User?

    var body: some View {
        ScrollView{
            VStack {
                Text("check out some furiends")
                    .font(.subheadline)
            }
           
        }
        .navigationTitle("Woof Community 🦴🏡")
        .navigationBarHidden(true)
        .onAppear() {
            setupViews()
        }
    
    }
    
    func setupViews() {
        usersService.getAllUsers()
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
