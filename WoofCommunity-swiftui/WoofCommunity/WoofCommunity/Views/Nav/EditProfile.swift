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
import FirebaseAuth

struct EditProfile: View {
    
    @EnvironmentObject var session: SessionStore
    @State var username: String = ""
    @State var humanName: String = ""
    @State var petName: String = ""
    @State var location: String = ""
    @State var instagram: String = ""
    @State var twitter: String = ""
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
    
    // if it has a bio, else ""
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
        
        // Update function
        StorageService.editProfile(userId: userId, username: username, bio: bio, petName: petName, humanName: humanName, location: location, instagram: instagram, twitter: twitter, imageData: imageData,  metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: {
            
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
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 100, height: 100)
//                            . padding(.top, 20)
//
                        WebImage(url: URL(string: session.session!.profileImageUrl))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            . padding(.top, 20)
                            .onTapGesture{
                                self.showingActionSheet = true
                            }
                        Text("+ profile photo")
                    }
                }
                
                Group{
                    FormField(value: $username, icon: "person.fill", placeholder: "Username")
                    FormField(value: $bio, icon: "book.fill", placeholder: "bio")
                    FormField(value: $humanName, icon: "person.fill", placeholder: "Hooman's Name")
                    FormField(value: $petName, icon: "pawprint.circle", placeholder: "Pet name")
                    FormField(value: $location, icon: "map", placeholder: "Location")
                    Text("Any Socials to connect?")
                    Text("Please enter just username ex: luluspaws__ ")
                    Text("ex: luluspaws__ ")
                    FormField(value: $twitter, icon: "desktopcomputer", placeholder: "Twitter")
                    FormField(value: $instagram, icon: "camera.metering.center.weighted", placeholder: "Instagram")
                }
                
                Button(action: edit){
                    
                    Text("Update Profile").font(.title).modifier(ButtonModifiers())
                    
                }.padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }
                Text("Changes will be effected next time you log in, Please fill in all info")
                
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
