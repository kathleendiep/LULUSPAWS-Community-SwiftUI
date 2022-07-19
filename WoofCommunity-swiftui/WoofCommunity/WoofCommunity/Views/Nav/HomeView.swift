//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Button(action: session.logout) {
                Text("Sign Out")
                    .font(.title)
                    .modifier(ButtonModifiers())
            }
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
//            }
            
            CustomTabView()
        }
    }
}

// MARK: - TABS
// home | explore | profile | signout
var tabs = ["house.fill", "map.fill", "person.crop.circle.fill"]

struct CustomTabView: View {
    @State var selectedTab = "house.fill"
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                Main()
                    .tag("house.fill")
                Explore()
                    .tag("map.fill")
                Profile()
                    .tag("person.crop.circle.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing:0) {
                ForEach(tabs, id: \.self) {
                 image in TabButton(image: image, selectedTab: $selectedTab)
                    
                    // equal spacing
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
         
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
    }
}

struct TabButton: View {
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.gray: Color.black)
                .padding()

        }
    }
}


