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
            VStack {
                SignInContainerView()
            }
            
            
            //            if SignInViewModel.isSignedIn {
            //                VStack {
            //                    Text("You are signed in")
            //                    Button(action: {
            //                        SignInViewModel.signOut()
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
            //        }
            //        .onAppear {
            //            signInVM.signedIn = signInVM.isSignedIn
            //        }
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
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no!"
    
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
                Button(action: signIn) {
                    Text("Sign In")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                }
                
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
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return "Please fill out info and provide image"
        }
        return nil
    }
    
    func clear(){
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        SignInViewModel.signIn(email: email, password: password, onSuccess: {
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
    
}

