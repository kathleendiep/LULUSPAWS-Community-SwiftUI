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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct SignUpContainerView: View {
    
    // MARK: - Properties
    
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var profileImage: Image?
    @State var pickedImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var signInVM = SignInViewModel()
    
    // MARK: - Functions
    
    func loadImage(){
        guard let inputImage = pickedImage else { return }
        
        profileImage = inputImage
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing:20) {
                
                // WELCOME
                VStack(alignment: .center) {
//                    Image(systemName: "square")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 150)
                    Text("Welcome").font(.system(size: 32, weight: .heavy))
                    Text("Sign up to start!").font(.system(size: 16, weight: .bold))
                }
                
                // PROFILE PHOTO
                VStack(spacing: 5){
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
                    }
                }
                
                // FIELDS
                VStack{
                    // todo: make it unique
                    FormField(value: $username, icon: "person.crop.circle.fill", placeholder: "username")
                    
                    FormField(value: $email, icon: "mail", placeholder: "email")
                    
                    FormField(value: $password, icon: "key", placeholder: "password", isSecure: true)
                    
                    Button(action: {
                        // pass in email and password
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        signInVM.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create")
                            .font(.title)
                            .modifier(ButtonModifiers())
                    })

                }
                .padding()
                
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
