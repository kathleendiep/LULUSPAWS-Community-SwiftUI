//
//  SearchBar.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/27/22.
//
import Foundation
import SwiftUI

struct SearchBar: View {
    
    @Binding var value: String
    @State var isSearching = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10){
                HStack(alignment: .center, spacing: 10) {
                    TextField("Search for Users", text: $value)
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
                            
                            Button(action:  {value = "" }){
                                Image(systemName: "xmark.circle.fill")
                            }
                        }.padding(.horizontal, 32)
                            .foregroundColor(.gray)
                    }
            }
        }.padding()
    }
}
