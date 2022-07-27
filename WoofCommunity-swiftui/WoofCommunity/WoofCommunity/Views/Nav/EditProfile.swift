//
//  EditProfile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI


struct EditProfile: View {
    
    @EnvironmentObject var session: SessionStore
    @State var username: String = ""
    @State var profileImage: Image?
    @State var pickedImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no!"
    @State private var bio: String = ""
    
    init(session: User?){
        _bio = State(initialValue:session?.bio ?? "")
        _username = State(initialValue: session?.username ?? "" )
    }
    
    
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if username.trimmingCharacters(in: .whitespaces).isEmpty || bio.trimmingCharacters(in: .whitespaces).isEmpty  {
            
            return "Please fill out info and provide image"
        }
        return nil
    }
    
    func clear(){
        self.bio = ""
        self.username = ""
//        self.imageData = Data()
//        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func edit() {
        
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        
        // converts the image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, username: username, bio: bio, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: {
            
            (errorMessage) in
            
            self.error = errorMessage
            self.showingAlert = true
            return
        })
        self.clear()
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("Edit Profile").font(.largeTitle)
                
                VStack{
                    Group{
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                . padding(.top, 20)
                                .onTapGesture{
                                    self.showingActionSheet = true
                                }
                            Text("pick a photo!")
                                .font(.caption)
                        } else {
                            WebImage(url: URL(string: session.session!.profileImageUrl))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                . padding(.top, 20)
                                .onTapGesture{
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
                FormField(value: $username, icon: "person.fill", placeholder: "Username")
                FormField(value: $bio, icon: "book.fill", placeholder: "bio")
                
                Button(action: edit){
                    
                    Text("Edit").font(.title).modifier(ButtonModifiers())
                    
                }.padding()
                    .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                }
                    Text("Changes will be effected next time you log in")
            }
        }.navigationTitle(session.session!.username)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                // from Utilities
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            }.actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text(""), buttons: [
                    .default(Text("Choose a photo")) {
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },
                    .default(Text("Take a photo")){
                        self.sourceType = .camera
                        self.showingImagePicker = true
                    },
                    .cancel()
                ])
            }
    }
}

//struct EditProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfile()
//    }
//}
