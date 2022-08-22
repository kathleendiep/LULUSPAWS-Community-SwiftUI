//
//  File.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct ButtonModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
            .background(Color.blue.opacity(0.9))
            .cornerRadius(5.0)
    }
}
