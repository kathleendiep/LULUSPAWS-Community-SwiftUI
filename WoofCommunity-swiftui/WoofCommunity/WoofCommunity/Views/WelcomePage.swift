//
//  WelcomePage.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 8/2/22.
//

import SwiftUI
import FirebaseAuth

struct WelcomePage: View {
    var body: some View {
        WelcomeThemeLayout()
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}

struct WelcomeThemeLayout: View {
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }
    
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
            
            VStack(spacing:20) {
                
                // WELCOME
                VStack(alignment: .center) {
                    Text("WoofCommunity").font(.system(size: 32, weight: .heavy))
                    Text("Check out and connect with other furiends").font(.system(size: 16, weight: .bold))
                    Image("WoofPageHomePage")
                        .resizable()
                }
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Sign In")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }
                // SIGN IN/UP BUTTON
                VStack(alignment: .center) {
                    
                    NavigationLink {
                        SignInView()
                    } label: {
                        Text("Sign In")
                            .font(.title)
                            .modifier(ButtonModifiers())
                    }
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                            .foregroundColor(Color.black)
                    }
                }.padding()
            }
        }
    }
}

