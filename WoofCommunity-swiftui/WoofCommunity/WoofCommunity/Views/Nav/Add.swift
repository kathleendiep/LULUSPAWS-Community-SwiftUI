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
        ScrollView {
            ZStack {
                LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .frame(width: 300)
                    .foregroundColor(Color.blue.opacity(0.3))
                    .blur(radius: 10)
                    .offset(x: -100, y: -150)
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .frame(width: 500, height: 500)
                    .foregroundStyle(LinearGradient(colors: [Color.purple.opacity(0.6), Color.mint.opacity(0.5)], startPoint: .top, endPoint: .leading))
                    .offset(x: 300)
                    .blur(radius: 30)
                    .rotationEffect(.degrees(30))
                
                Circle()
                    .frame(width: 450)
                    .foregroundStyle(Color.pink.opacity(0.6))
                    .blur(radius: 20)
                    .offset(x: 200, y: -200)
                
                VStack(){
                    VStack(alignment: .center, spacing: 5) {
                        //                        Text("Upload A Post").font(.largeTitle)
                        if postImage != nil {
                            postImage!.resizable()
                                .scaledToFit()
                                .frame(width: 300, height:200)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                            
                        } else {
                            Image(systemName: "photo.fill").resizable()
                                .scaledToFit()
                                .frame(width: 200, height:200)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                            Text("+ add photo")
                            
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
                    .frame(width: 400)
            }
        }.navigationTitle("Upload A Post")
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Add()
    }
}
