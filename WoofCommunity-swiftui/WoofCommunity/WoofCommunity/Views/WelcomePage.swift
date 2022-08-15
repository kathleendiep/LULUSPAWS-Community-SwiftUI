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
        NavigationView {
            VStack {
                WelcomeThemeLayout()
            }
        }
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
                WelcomePopupView()
                
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
            NavigationLink {
                SignInView()
            } label: {
                Text("Sign In")
                    .font(.title)
                    .modifier(ButtonModifiers())
            }.frame(width: 300)
        
        }
    }
}


struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
struct WelcomePopupView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.5)
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
                .padding()
            
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("LULUS PAWS 🦴🏡")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.top, 20)
                Text("check out our pupventures with some furry cute friends")
                    .font(.footnote)
                
                Image("WoofPageHomePage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200, height: 200)
                    .padding(.leading, 40)
                
            }
            .padding()
            .frame(width: 300, height: 100)
            .foregroundColor(Color.black.opacity(0.8))
           
        }
    }
}
