//  SwiftUIView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct Add: View {
    
    @State var postImage: Image?
    @State var pickedImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no!"
    @State private var text = ""
    
    func loadImage(){
        guard let inputImage = pickedImage else { return }
        postImage = inputImage
    }
     
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
   
        // firebase
        PostViewModel.uploadPost(caption: text, imageData: imageData, onSuccess: {(post) in
            self.clear()
        }) {
            (errorMessage) in
             
            self.error = errorMessage
            self.showingAlert = true
            return
            
        }
    }
    
    func clear() {
        self.text = ""
        self.imageData = Data()
        self.postImage = Image(systemName: "photo.fill")
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "Please add a caption and provide an image"
        }
        return nil
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6759886742, green: 0.9469802976, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom)
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack {
            VStack(spacing: 5) {
                Text("Upload A Post").font(.largeTitle)
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300, height:200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                    
                } else {
                    Image(systemName: "photo.fill").resizable()
                        .frame(width: 300, height:200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                    Text("+ photo")
                      
                }
            }
            
            TextEditor(text: $text)
                .frame(height:200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            
            Button(action: uploadPost) {
                Text("Upload Post").font(.title).modifier(ButtonModifiers())
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }.padding()
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
}

