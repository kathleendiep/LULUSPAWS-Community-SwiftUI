//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//
import SwiftUI
import MapKit
import CoreLocation

struct HomePageListView: View {
    
    @ObservedObject var viewModel = UserViewModel()
    
    // Landing Pad
    var user: User?
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink {
                    SignInView()
                    
                } label: {
                    Text("Sign in")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                }
                
                List(viewModel.users) { user in
                    
                    NavigationLink {
                        UserDetailView(userViewModel: viewModel, user: user)
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .fontWeight(.bold)
                            Text(user.petName)
                        }
                    }
                }
                Divider()
            }
            .navigationTitle("Woof Community 🦴🏡")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        // Destination
                        UserDetailView(userViewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
    } // end of body
    
    init() {
        viewModel.getData()
    }
    
}

struct HomePageListView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageListView()
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
