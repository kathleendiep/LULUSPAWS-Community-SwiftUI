//
//  SignIn.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/14/22.
//

import SwiftUI
import FirebaseAuth

// similar to AppViewModel

class SignInViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
        }
    }
}

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var signInVM : SignInViewModel
    
    var body: some View {
        NavigationView {
            VStack {
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
                        
                        signInVM.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("sign in")
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
