//
//  SearchBar.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/27/22.
//
import Foundation
import SwiftUI

struct SearchBar: View {
    
    @State var searchUsers = ""
    @State var isSearching = false
    
    var body: some View {
        HStack {
            
            TextField("Search for Users", text: $searchUsers)
                .padding(.leading, 24)
        }.padding()
            .background(Color(.systemGray5))
            .cornerRadius(6.0)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay{
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    Button(action: {searchUsers = "" }){
                        Image(systemName: "xmark.circle.fill")
                    }
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            }
    }
}


