//
//  SignIn.swift
//  WoofCommunity
//
import SwiftUI
import FirebaseAuth

struct SignInView: View {
    var body: some View {
        NavigationView {
            VStack {
                SignInContainerView()
            }
        }
    }
}

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
            Color.white
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle( LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width:1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)

             Circle()
                 .frame(width: 300)
                 .foregroundColor(Color.blue.opacity(0.3))
                 .blur(radius: 10)
                 .offset(x: -100, y: -150)
     
             Circle()
                 .frame(width: 450)
                 .foregroundStyle(Color.pink.opacity(0.6))
                 .blur(radius: 20)
                 .offset(x: 200, y: -200)
            
            VStack{
                Image("LuluspawsCommunityLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 150)
                VStack(alignment: .center, spacing: 10) {
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.gray)
                        .padding()
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.gray)
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
            .frame(width: 300)
        }
        .navigationTitle("Sign In")
        .foregroundColor(Color.white)
        
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

