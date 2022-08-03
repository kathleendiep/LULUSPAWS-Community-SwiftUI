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
        ZStack {
            
            Color.white
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle( LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width:1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            Circle()
                .frame(width: 300)
                .foregroundColor(Color.blue.opacity(0.3))
                .blur(radius: 10)
                .offset(x: -100, y: -150)
            
            Circle()
                .frame(width: 450)
                .foregroundStyle(Color.pink.opacity(0.6))
                .blur(radius: 20)
                .offset(x: 200, y: -200)
     
            VStack(alignment: .center)  {
                
                // WELCOME
            
                    Text("Welcome").font(.system(size: 32, weight: .heavy))
                    Text("Sign up to start!").font(.system(size: 16, weight: .bold))
                
                
                // PROFILE PHOTO
                VStack(alignment: .center){
                    Group {
                        Text("Profile photo")
                            .font(.system(size: 14, weight: .bold))
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
          
              // FIELDS
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
                                Text("Sign Up")
                                    .font(.title)
                                    .modifier(ButtonModifiers())
                                    .frame(width: 300)
                            }
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                        }.padding()
                        

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
            .padding(.leading, 20)
 
        }
  
    }
}


