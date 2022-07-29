//
//  ContentView.swift
//  Dribble-3D-App
//
//  Created by AJ Picard on 7/21/20.
//

import SwiftUI

struct PreviewDesign: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9682741117, green: 0.9682741117, blue: 0.9682741117, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Header()
                
                SearchBarEngine()
                    .padding(.top, 10)
                Buttons()
                    .padding(.vertical, 20)
                Cards()
                    .padding(.top, 20)
                Tabbar()
                    .offset(y: 60)
            }
        }
    }
}

struct PreviewDesign_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDesign()
    }
}

//MARK: Header
struct Header: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning,")
                    .font(.system(size: 19, weight: .medium, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                Text("Shaileen")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                    .padding(.top, 5)
            }
            .padding(.leading, 30)
            Spacer()
            Image("Aj")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 30)
        }
    }
}

//MARK: Search
struct SearchBarEngine: View {
    var body: some View {
        HStack {
            Text("Search for 3D products")
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 26, weight: .medium, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                .padding(.trailing, 20)
            
        }
        .frame(width: 350, height: 54)
        .background(Color.white)
        .cornerRadius(14)
    }
}

//MARK: Buttons
struct Buttons: View {
    var body: some View {
        VStack {
            HStack (spacing: 35) {
                VStack {
                    ZStack{
                        Image(systemName: "clock")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    .frame(width: 60, height: 60)
                    .background(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                    .cornerRadius(10)
                    
                    Text("Recent")
                        .font(.system(size: 12, weight: .bold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                        .padding(.top, 10)
                }
                
                VStack {
                    ZStack{
                        Image(systemName: "flame")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
                    Text("Trending")
                        .font(.system(size: 12, weight: .bold, design: .serif))
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                VStack {
                    ZStack{
                        Image(systemName: "crown")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
                    Text("Popular")
                        .font(.system(size: 12, weight: .bold, design: .serif))
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                VStack {
                    ZStack{
                        Image(systemName: "diamond")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
                    Text("Premium")
                        .font(.system(size: 12, weight: .bold, design: .serif))
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                
                
            }
            
        }
    }
}

//MARK: Cards
struct Cards: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended Products")
                .font(.system(size: 22, weight: .bold, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
            
            ScrollView (.horizontal) {
                HStack (spacing: 40) {
                    VStack {
                        Image("Geometry")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack(alignment: .leading){
                            Text("Geometry 3D Elements")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                                .padding(.horizontal, 10)
                            Text("Hold up a rectangular piece of paper and ask all the students")
                                .font(.system(size: 15, weight: .medium, design: .serif))
                                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                                .lineLimit(3)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                                .padding(.bottom, 15)
                        }
                        .frame(height: 100)
                    }
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                    VStack {
                        Image("Abstract")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack(alignment: .leading){
                            Text("Abstract 3D Elements")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                                .padding(.horizontal, 10)
                            Text("An Abstract may act as a stand alone.")
                                .font(.system(size: 15, weight: .medium, design: .serif))
                                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                                .lineLimit(3)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                                .padding(.bottom, 15)
                        }
                        .frame(height: 100)
                    }
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                }
            }
            .padding(.top, 10)
        }
        .padding(.leading, 30)
    }
}

//MARK: Tabbar
struct Tabbar: View {
    var body: some View {
        HStack (spacing: 60) {
            VStack {
                Image(systemName: "house")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
            }
            VStack {
                Image(systemName: "heart")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
            VStack {
                Image(systemName: "cube")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
            VStack {
                Image(systemName: "person")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
        }
        .frame(height: 84)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
        .cornerRadius(20)
    }
}
