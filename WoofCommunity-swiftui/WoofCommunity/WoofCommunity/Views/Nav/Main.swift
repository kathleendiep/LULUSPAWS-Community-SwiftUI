//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI
import Firebase

struct Main: View {
    var body: some View {
        MainFeed()
    }
}

struct MainFeed : View {
    
    // MARK: - Properties
    @EnvironmentObject var session: SessionStore
    @ObservedObject var postCardViewModel = PostCardViewModel()
    @ObservedObject var postViewModel = PostViewModel()
    @StateObject var mainViewModel = MainViewModel()
    // append the user fetch here
    @State var users: [User] = []
    @State var posts: [Post] = []
    
    func loadAllUsers() {
        
        // fetchUser
        MainViewModel.fetchUsers() {
            
            (users) in
            
            self.users = users
            
        }
    }
    
    var body: some View{
        
        ScrollView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6759886742, green: 0.9469802976, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack{
                    
                    ZStack {
                        
                        Circle()
                            .frame(width: 400, height: 400)
                            .offset(x: 150, y: -200)
                            .foregroundColor(Color.purple.opacity(0.6))
                            .blur(radius: 8)
                        Circle()
                            .frame(width: 300, height: 300)
                            .offset(x: -100, y: -125)
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.4))
                            .blur(radius: 8)
                        
                        PopupView()
                        
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Header(user: self.session.session)
                        Text("Checkout some users")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .padding(.top, 5)
                    }
                    
                    UserProfile()
                
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear{
            self.loadAllUsers()
        }
    }
    
}

struct PopupView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.5)
                .frame(width: 300, height: 500)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
                .padding()
            
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("LULUS PAWS 🦴🏡")
                    .font(.system(size: 24, weight: .bold, design: .rounded))

                Text("check out our pupventures with some furry cute friends")
                    .font(.footnote)
                
                Image("WoofPageHomePage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200, height: 200)
            }
            .padding()
            .frame(width: 300, height: 400)
            .foregroundColor(Color.black.opacity(0.8))
        }
        
    }
}


//MARK: Header
struct Header: View {
    
    var user: User?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("🦴 Woof Woof,")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(Color.black)
                
                if user != nil {
                    Text("Welcome back,")
                        .font(.system(size: 15, weight: .thin, design: .serif))
                        .foregroundColor(Color.white)
                    Text("\(user!.username)")
                        .font(.system(size: 20, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                    
                }
            }
        }
    }
}
