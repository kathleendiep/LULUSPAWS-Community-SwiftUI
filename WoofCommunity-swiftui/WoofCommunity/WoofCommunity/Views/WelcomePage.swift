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
            
            ZStack {
                
                // WELCOME
                VStack(alignment: .center) {
                    Text("WoofCommunity")
                        .font(.system(.largeTitle)).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                    Text("Check out and connect with other furiends").font(.system(size: 16, weight: .bold))
                    Image("WoofPageHomePage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:300, height: 300)
                }.frame(width: 500)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
              
                // SIGN IN/UP BUTTON
                VStack(alignment: .center) {
                    
                    NavigationLink {
                        SignInView()
                    } label: {
                        Text("Sign In")
                            .font(.title)
                            .modifier(ButtonModifiers())
                    }.frame(width: 300)
                            

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

