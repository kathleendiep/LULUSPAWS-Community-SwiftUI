////
////  UserDetailView.swift
////  WoofCommunity
////
////  Created by Kathleen Diep on 7/12/22.
////
//
//import SwiftUI
//
//enum Mode {
//    case new
//    case edit
//}
//
//enum Action {
//    case delete
//    case done
//    case cancel
//}
//
//// add or edit
//struct UserEditView: View {
//    
//    // these terms get passed
//    @ObservedObject var userViewModel = UserViewModel() // is this always the same name "userViewModel" will be referenced in other ones, so cant redeclare name ?
//    
//    // Environment Values
//    @Environment(\.presentationMode) private var presentationMode
//    @State var presentActionSheet = false
//    @State var userName: String = ""
//    @State var userPetName: String = ""
//    
//    // Landing Pad
//    var user: User?
//    var mode: Mode = .new // we will toggle this from other page
//    var completionHandler: ((Result<Action, Error>) -> Void)?
//    
//    var cancelButton: some View {
//        Button(action: { self.handleCancelTapped() }) {
//            Text("Cancel")
//        }
//    }
//    
//    // add item
//    var saveButton: some View {
//        Button(action: { self.handleDoneTapped() }) {
//            Text(mode == .new ? "Done" : "Save")
//        }
//        .disabled(!userViewModel.modified)
//    }
//    
//    private func editButton(action: @escaping () -> Void) -> some View {
//        Button(action: { action() }) {
//            Text("Edit")
//        }
//    }
//    
//    var body: some View {
//        
//        NavigationView {
//            Form {
//                Section(header: Text("User")) {
//                    TextField("User", text: $userViewModel.user.name)
//                }
//                
//                Section(header: Text("Pet")) {
//                    TextField("Pet", text: $userViewModel.user.petName)
//                }
//                
//                // clears it
//                if mode == .edit {
//                    Section {
//                        Button("Delete book") { self.presentActionSheet.toggle() }
//                            .foregroundColor(.red)
//                    }
//                }
//            }
//            .navigationTitle(mode == .new ? "New User" : userViewModel.user.name)
//            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
//            .navigationBarItems(
//                leading: cancelButton,
//                trailing: saveButton // done or save? <- handle save
//            )
//            .actionSheet(isPresented: $presentActionSheet) {
//                ActionSheet(title: Text("Are you sure?"),
//                            buttons: [
//                                .destructive(Text("Delete book"),
//                                             action: { self.handleDeleteTapped() }),
//                                .cancel()
//                            ])
//            }
//        }
//        
//    }
//    // MARK: - Functions
//    func handleCancelTapped() {
//        self.dismiss()
//    }
//    
//    func handleDoneTapped() {
//        self.userViewModel.handleDoneTapped()
//        self.dismiss()
//    }
//    
//    func handleDeleteTapped() {
//        self.userViewModel.handleDeleteTapped()
//        self.dismiss()
//        self.completionHandler?(.success(.delete))
//    }
//    func dismiss() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
//}
//
//struct UserEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(id: "TestID", name: "TestUser", petName: "TestPetName")
//        let userVM = UserViewModel(user: user)
//        
//        return UserEditView(userViewModel: userVM, mode: .edit)
//    }
//}
//
