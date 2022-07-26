//
//  EditProfile.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/25/22.
//

import SwiftUI

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
        if username.trimmingCharacters(in: .whitespaces).isEmpty || bio.trimmingCharacters(in: .whitespaces).isEmpty ||
          imageData.isEmpty {
            
            return "Please fill out info and provide image"
        }
        return nil
    }
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
