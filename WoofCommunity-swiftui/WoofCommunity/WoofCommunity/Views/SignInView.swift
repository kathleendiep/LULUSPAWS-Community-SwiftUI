//
//  SignIn.swift
//  WoofCommunity
//

import Foundation
import SwiftUI
import FirebaseAuth

// MARK: SignInView
struct SignInView: View {

    // @EnvironmentObject var signInVM: SignInViewModel
    @ObservedObject var signInVM = SignInViewModel()
    
    var isPreview: Bool = false

    init(isPreview: Bool=false) {
        if !isPreview {
            signInVM = SignInViewModel()
        }
    }
    
    var body: some View {
        NavigationView {
            
            SignInContainerView()
//            if signInVM.isSignedIn {
//                VStack {
//                    Text("You are signed in")
//                    Button(action: {
//                        signInVM.signOut()
//                    }, label: {
//
//                        Text("Sign Out")
//                            .frame(width: 200, height: 50)
//                            .foregroundColor(Color.blue)
//                            .background(Color.red)
//                            .padding()
//                    })
//
//                }
//            } else {
//                    SignInContainerView()
//            }
        }
        .onAppear {
            signInVM.signedIn = signInVM.isSignedIn
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isPreview: true)
    }
}

// MARK: - Views
struct SignInContainerView: View {
    
    @State var email = ""
    @State var password = ""
    
    @ObservedObject var signInVM = SignInViewModel()
        
    var body: some View {
            VStack {
                Image(systemName: "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                VStack {
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    SecureField("Email Address", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    Button(action: {
                        // pass in email and password
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        signInVM.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                    NavigationLink("Create an account", destination: SignUpContainerView())
                    
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("sign in")
        }
    }


struct SignUpContainerView: View {
    
    @State var email = ""
    @State var password = ""
    @State var active = true
    
    @ObservedObject var signInVM = SignInViewModel()
 
    var body: some View {
            VStack {
                // enter logo here
                Image(systemName: "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                VStack {
                    TextField("Email Address", text: $email)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    SecureField("Password", text: $password)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    NavigationLink(destination: HomePageListView() , isActive: $active){
                        Button(action: {
                            // pass in email and password
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            
                            signInVM.signUp(email: email, password: password)
                            
                        }, label: {
                            Text("Create")
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50)
                                .cornerRadius(8)
                                .background(Color.blue)
                        })
                    }
                  
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Create an account")
        }
    }

