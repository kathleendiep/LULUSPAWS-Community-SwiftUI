//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomePageListView: View {
    
    // Should i change this to environment
    @ObservedObject var viewModel = UserViewModel()
    
    // Landing Pad
    var user: User?
    
    private func userRowView(user: User) -> some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .fontWeight(.bold)
                        Text(user.petName)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink {
                    SignInView()
                    
                } label: {
                    
                    Text("Sign in")
                        .foregroundColor(Color.black)
                        .background(.orange).frame(width: 300, height: 50)
                    
                }
                List {
                    ForEach (viewModel.users) { user in
                        userRowView(user: user)
                    }
                }
                
                Divider()
            }
            .navigationTitle("Woof Community 🦴🏡")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        
                        // Destination
                        UserDetailView(user: viewModel.user)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear() {
                self.viewModel.getData()
            }
        }
    } // end of body
}

struct HomePageListView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: "1", name: "Kathleen", petName: "Louis")
        HomePageListView(user: user)
    }
}
//
//// MARK: - STRUCT VIEWS




//struct Home : View {
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                Spacer()
//            }
//        }
//    }
//
//}
