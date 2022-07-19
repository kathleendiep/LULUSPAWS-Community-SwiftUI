//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI

struct Main: View {

    @ObservedObject var signInVM = SignInViewModel()

    // Landing Pad
    var user: User?
    
    private func userRowView(user: User) -> some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .fontWeight(.bold)
                        Text(user.bio)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
    
            VStack {
                Text("check out some furiends")
         
            }
            .navigationTitle("Woof Community 🦴🏡")
            // MARK: - icon: sign in? or sign out
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SignInView()
                    } label: {
                        if SignInViewModel.isSignedIn {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                        }
                }
            }
                }
//            .onAppear() {
//                 let sampleUser = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")
//                SignInViewModel.getUserId( (user != nil) ? user : sampleUser)
////                SignInViewModel.getUserId(userId: user.id)
//            }
        
        }
    } // end of body
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
//        let user = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")
        Main()
    }
}
