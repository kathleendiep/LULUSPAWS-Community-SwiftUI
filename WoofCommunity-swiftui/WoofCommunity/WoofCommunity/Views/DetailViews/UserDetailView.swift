//
//  UserDetailView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/12/22.
//

import SwiftUI

enum Mode {
  case new
  case edit
}

enum Action {
  case delete
  case done
  case cancel
}

struct UserDetailView: View {

    @ObservedObject var userViewModel = UserViewModel()
    // Environment Values
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @State var userName: String = ""
    @State var userPetName: String = ""
    
    // Landing Pad
    var user: User?
    var mode: Mode = .new
     var completionHandler: ((Result<Action, Error>) -> Void)?
      
     var cancelButton: some View {
       Button(action: { self.handleCancelTapped() }) {
         Text("Cancel")
       }
     }
    
    
    // add item
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!userViewModel.modified)
    }
   
    var body: some View {
        
        NavigationView {
           Form {
             Section(header: Text("User")) {
                 TextField("User", text: $userViewModel.user.name)
             }
              
             Section(header: Text("Pet")) {
               TextField("Pet", text: $userViewModel.user.petName)
             }
                
             if mode == .edit {
               Section {
                 Button("Delete") { self.presentActionSheet.toggle() }
                   .foregroundColor(.red)
               }
             }
           }
           .navigationTitle(mode == .new ? "New User" : userViewModel.user.name)
           .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
           .navigationBarItems(
             leading: cancelButton,
             trailing: saveButton // done or save? <- handle save
           )
         }
//        VStack(spacing: 5) {
//            Text("Add a user")
//                .font(.title)
//            TextField("Name", text: $userName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Pet name", text: $userPetName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//
//        VStack(spacing: 5) {
//                   Text("Add a user")
//                       .font(.title)
//                   TextField("Name", text: $userName)
//                       .textFieldStyle(RoundedBorderTextFieldStyle())
//                   TextField("Pet name", text: $userPetName)
//                       .textFieldStyle(RoundedBorderTextFieldStyle())
//
//            Button(action: {
//
//                // Call add data
//                userViewModel.addData(name: userName, petName: userPetName)
//                // Clear the text fields
//                userName = ""
//                userPetName = ""
//
//            }, label: {
//                Text("add user")
//            })
//        }
    }
    
    // MARK: - Functions
    func handleCancelTapped() {
       self.dismiss()
     }
    func handleDoneTapped() {
      self.userViewModel.handleDoneTapped()
      self.dismiss()
    }
    
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
            let user = User(id: "TestID", name: "TestUser", petName: "TestPetName")
            let userVM = UserViewModel(user: user)
            return UserDetailView(userViewModel: userVM, mode: .edit)
    }
}

struct saveButton: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    
    var user: User
    var body: some View {
        Button(action: {
            // Call add data
            userViewModel.updateData(user)
            
        }, label: {
            Text("save")
        })
    }
    
}


//
//struct UserDetails: View {
//    @ObservedObject var userViewModel = UserViewModel()
//
//    var user: User
//
//    var body: some View {
//        HStack {
//
//            Text(user.name)
//            Text(user.petName)
//
//
//            Button(action: {
//                userViewModel.updateData(userToUpdate: user, name: userName, petName: userPetName)
//            }) {
//                Image(systemName: "square")
//            }
//
//
//        }
//    }
//}
//
// MARK: - FUNCTIONS
//func prepareForUpdate() {
//    let name = userName
//    let petName = userPetName
//    
//    guard !name.isEmpty, !petName.isEmpty else { return }
//          if let user = user {
//              userViewModel.updateData(userToUpdate: user, name: name, petName: petName)
//          }
//}
