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
        VStack {
            Text("Upload A Post").font(.largeTitle)
            
            VStack {
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

