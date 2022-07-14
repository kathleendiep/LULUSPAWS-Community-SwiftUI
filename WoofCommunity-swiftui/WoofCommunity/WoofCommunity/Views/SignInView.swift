//
//  SignIn.swift
//  WoofCommunity
//

import Foundation
import SwiftUI
import FirebaseAuth

// MARK: - ViewModel
// similar to AppViewModel
class SignInViewModel: NSObject, ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
}

// MARK: SignInView
struct SignInView: View {

//    @State var signInVM: SignInViewModel
    @ObservedObject var signInVM = SignInViewModel()
    var isPreview: Bool = false
    
    init(isPreview: Bool=false) {
        if !isPreview {
            signInVM = SignInViewModel()
        }
    }
    
    var body: some View {
        NavigationView {
            if signInVM.signedIn {
                Text("You are signed in")
            } else {
                SignInContainerView()
            }
        }
        .onAppear {
            signInVM.signedIn = signInVM.isSignedIn
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isPreview: true)
    }
}

// MARK: - Views
struct SignInContainerView: View {
    
    @State var email = ""
    @State var password = ""
    var isPreview: Bool = false
    @State var signInVM: SignInViewModel?
    
    init(isPreview: Bool=false) {
        if !isPreview {
            signInVM = SignInViewModel()
        }
    }
    
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
                        
                        signInVM?.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                    NavigationLink("Create Account", destination: SignUpContainerView())
                    
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
   
    @State var signInVM: SignInViewModel?
 
    
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
                    SecureField("Email Address", text: $password)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    Button(action: {
                        // pass in email and password
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        signInVM?.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Create an account")
        }
    }

