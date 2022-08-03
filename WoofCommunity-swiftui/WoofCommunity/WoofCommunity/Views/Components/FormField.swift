//
//  FormField.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct FormField: View {
    
    @Binding var value: String
    
    var icon: String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        Group {
            HStack(alignment: .center, spacing: 5 ) {
                Spacer()
                Image(systemName: icon).padding()
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $value)
                    } else {
                        TextField(placeholder, text: $value)
                    }
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    Spacer()
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth:4))
            .frame(width:300)
            .padding(.vertical, 10)
            
                
        }
    }
}
