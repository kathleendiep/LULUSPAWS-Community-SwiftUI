//
//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//
import SwiftUI
import MapKit
import CoreLocation

struct HomePageListView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    @State var userName = ""
    @State var userPetName = ""
    
    // Landing Pad
    var user: User?
     
    var body: some View {
        NavigationView {
            VStack{
                
                List (userViewModel.users) { user in
                    
                    VStack {
                        Text(user.name)
                        Text(user.petName)
                        Spacer()
                        
                        
                        Button(action: { prepareForUpdate()}, label: {
                            ZStack {
                                // very bottom
                                Rectangle().fill(.ultraThinMaterial)
                                    .cornerRadius(12)
                                // very top
                                Text("update")
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        
                        
                        // Update
                        Button(action: {
                            userViewModel.updateData(user, user.name, user.petName) }, label: {
                                Image(systemName:"pencil")
                            })
                        .buttonStyle(BorderlessButtonStyle())
                        
                        // Delete
                        //                        Button(action: {
                        //                            userViewModel.deleteData(userToDelete: user) }, label: {
                        //                                Image(systemName:"minus.circle")
                        //                            })
                    }
                }
                Divider()
                
                VStack(spacing: 5) {
                    Text("Add a user")
                        .font(.title)
                    TextField("Name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Pet name", text: $userPetName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        
                        // Call add data
                        userViewModel.addData(name: userName, petName: userPetName)
                        
                        // Clear the text fields
                        userName = ""
                        userPetName = ""
                        
                    }, label: {
                        Text("add user")
                    })
                }
                .padding()
            }
            .navigationTitle("Woof Community 🦴🏡")
        }
        
        
    } // end of body
    
    // MARK: - FUNCTIONS
    func prepareForUpdate() {
        let name = userName
        let petName = userPetName
        
        guard !name.isEmpty, !petName.isEmpty else { return }
              if let user = user {
                  userViewModel.updateData(user, name, petName)
              }
    }
    
    init() {
        userViewModel.getData()
    }
    
}

struct HomePageListView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageListView()
    }
}
//
//// MARK: - STRUCT VIEWS
//
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
