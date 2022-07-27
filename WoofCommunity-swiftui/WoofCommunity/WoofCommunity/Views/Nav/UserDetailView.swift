////
////  UserDetailView.swift
////  WoofCommunity
////
////  Created by Kathleen Diep on 7/12/22.
////
//
//import SwiftUI
//
//struct UserDetailView: View {
//
//    // Environment Values
//    @Environment(\.presentationMode) var presentationMode
//     @State var presentEditUser = false
//      
//    // Landing Pad
//    var user: User
//    
//   private func editButton(action: @escaping () -> Void) -> some View {
//     Button(action: { action() }) {
//       Text("Edit")
//     }
//   }
//    
//    var body: some View {
//        
//        NavigationView {
//           Form {
//             Section(header: Text("User")) {
//                 Text(user.username)
//             }
//               
//           Section(header: Text("Pet Name")) {
//               Text(user.profileImageUrl)
//           }
//        // to do: can add a delete button if it's your profile
//           }
//           .navigationBarTitle(user.username)
//              .navigationBarItems(trailing: editButton {
//                self.presentEditUser.toggle()
//              })
////              .sheet(isPresented: self.$presentEditUser) {
////                  UserEditView(userViewModel: UserViewModel(user: user), mode: .edit) { result in
////                  if case .success(let action) = result, action == .delete {
////                    self.presentationMode.wrappedValue.dismiss()
////                  }
////                }
////              }
//            }
//    }
//
//    // MARK: - Functions
//    func dismiss() {
//      self.presentationMode.wrappedValue.dismiss()
//    }
//}
//
//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(email: "email", profileImageUrl: "img", username: "username", bio: "about me")
//        
//        return NavigationView {
//            UserDetailView(user:user)
//        }
//    }
//}
