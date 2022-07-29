//
//  SignIn.swift
//  WoofCommunity
//
import SwiftUI
import FirebaseAuth

// MARK: SignInView
struct SignInView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                SignInContainerView()
            }
        }
    }
}

// MARK: - Views
struct SignInContainerView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no!"
    
    var body: some View {
        
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
            
            
            VStack{
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
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    // LINKS
                    NavigationLink {
                        HomeView()
                    } label: {
                        Button(action: { signIn()
                            
                            listen()
                            
                        }){
                            Text("Sign In")
                                .font(.title)
                                .modifier(ButtonModifiers())
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                        }
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

