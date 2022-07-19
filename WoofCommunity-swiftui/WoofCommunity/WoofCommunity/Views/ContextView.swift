//
//  ContextView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct ContextView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        VStack{
            HomeView()
        }
    }
}

struct ContextView_Previews: PreviewProvider {
    static var previews: some View {
        ContextView()
    }
}
