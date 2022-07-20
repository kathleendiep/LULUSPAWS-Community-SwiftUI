////  HomePageListView.swift
////  WoofCommunity
////
////  Created by Kathleen Diep on 7/11/22.
////
//
//import SwiftUI
//
//struct Main: View {
//    
//    // Should i change this to environment
////    @ObservedObject var viewModel = UserViewModel()
//
//    @ObservedObject var signInVM = SignInViewModel()
////    @EnvironmentObject var signInVM: SignInViewModel
//    
//    // Landing Pad
//    var user: User?
//    
//    private func userRowView(user: User) -> some View {
//        NavigationLink(destination: UserDetailView(user: user)) {
//            VStack(alignment: .leading) {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(user.username)
//                            .fontWeight(.bold)
//                        Text(user.bio)
//                    }
//                }
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//    
//            VStack {
//                
//                if !signInVM.signedIn {
//                    VStack {
//                        NavigationLink {
//                            SignUpView()
//                        } label: {
//                            Text("Sign Up")
//                                .foregroundColor(Color.black)
//                                .background(.orange).frame(width: 300, height: 50)
//                            
//                        }
//                        
//                        NavigationLink {
//                            SignInView()
//                        } label: {
//                            Text("Sign in")
//                                .foregroundColor(Color.black)
//                        }
//                    }
//                } else {
//                    Image(systemName: "pawprint.circle.fill")
//                        .resizable()
//                }
//
//                List {
//                    // to do: see how to get data
//                    ForEach (signInVM.users) { user in
//                        userRowView(user: user)
//                    }
//                }
//                Divider()
//                CustomTabView()
//            }
//            .navigationTitle("Woof Community 🦴🏡")
//            // MARK: - icon: sign in? or sign out
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        SignInView()
//                    } label: {
//                        if signInVM.isSignedIn {
//                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
//                        } else {
//                            Image(systemName: "person.crop.circle.fill")
//                        }
//                }
//            }
//                }
//            .onAppear() {
//                self.signInVM.getData()
////                SignInViewModel.getUserId(userId: user.id)
//            }
//        
//        }
//    } // end of body
//}
//
//struct Main_Previews: PreviewProvider {
//    static var previews: some View {
////        let user = User(id: "", email: "", profileImageUrl: "", username: "", bio: "")
//        Main()
//    }
//}
