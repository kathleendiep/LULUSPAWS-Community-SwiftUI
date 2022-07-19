//
//  SignIn.swift
//  WoofCommunity
//


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
            
            if signInVM.isSignedIn {
                VStack {
                    Text("You are signed in")
                    Button(action: {
                        signInVM.signOut()
                    }, label: {

                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.blue)
                            .background(Color.red)
                            .padding()
                    })

                }
            } else {
                    SignInContainerView()
            }
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
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                            .foregroundColor(Color.black)
                    }
                    
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("sign in")
        }
    
    // MARK: - Functions
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill out info"
        }
        return nil
    }
    
    func clear(){
        self.email = ""
        self.password = ""
    }
    
//    
//    func signIn() {
//        if let error = errorCheck() {
//            self.error = error
//            self.showingAlert = true
//            self.clear()
//            return
//        }
//    }
    }

