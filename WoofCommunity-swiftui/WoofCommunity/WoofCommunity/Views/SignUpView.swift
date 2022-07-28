//
//  SignUpView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        SignUpContainerView()
    }
}


struct SignUpContainerView: View {
    
    // MARK: - Properties
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var petName: String = ""
    @State var humanName: String = ""
    @State var profileImage: Image?
    @State var pickedImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no!"
    @State private var isLinkActive = false
    
    // MARK: - Functions
    func loadImage(){
        guard let inputImage = pickedImage else { return }
        
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "Please fill out info and provide image"
        }
        return nil
    }
    
    func clear(){
        self.email = ""
        self.username = ""
        self.password = ""
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        SignInViewModel.signUp(username: username, email: email, password:password, petName: petName, humanName: humanName, imageData: imageData, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing:20) {
                
                // WELCOME
                VStack(alignment: .center) {
                    Text("Welcome").font(.system(size: 32, weight: .heavy))
                    Text("Sign up to start!").font(.system(size: 16, weight: .bold))
                }
                
                // PROFILE PHOTO
                VStack(spacing: 5){
                    Group {
                        Text("Profile photo")
                            .font(.subheadline)
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                . padding(.top, 20)
                                .onTapGesture{
                                    self.showingActionSheet = true
                                }
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                . padding(.top, 20)
                                .onTapGesture{
                                    self.showingActionSheet = true
                                }
                            Text("pick a photo!")
                                .font(.caption)
                        }
                    }
                }
                
                // FIELDS
                VStack{
                    // todo: make it unique
                    FormField(value: $username, icon: "person.crop.circle.fill", placeholder: "username")
                    
                    FormField(value: $email, icon: "mail", placeholder: "Email")
                    
                    FormField(value: $password, icon: "key", placeholder: "Password", isSecure: true)
                    
                    
                    //                    FormField(value: $petName, icon: "pawprint.circle", placeholder: "Pet's name")
                    //
                    //                    FormField(value: $humanName, icon: "pawprint.circle", placeholder: "Hooman's name")
                    
                    //                    Button(action: {
                    
                    NavigationLink(destination: SignInView(), isActive: $isLinkActive){
                        Button(action: { signUp()
                            self.isLinkActive = true
                            
                        }) {
                            Text("Create")
                                .font(.title)
                                .modifier(ButtonModifiers())
                        }
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }.padding()
                    
                    Spacer()
                }
                .padding()
                
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
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
}
