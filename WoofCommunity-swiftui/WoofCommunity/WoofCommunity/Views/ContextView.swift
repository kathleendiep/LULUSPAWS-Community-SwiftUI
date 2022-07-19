//
//  ContextView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI

struct ContextView: View {
    
    @EnvironmentObject var session: SessionStore
    
    // Listen for session.user
    func listen(){
        session.listen()
    }
    var body: some View {
        
        Group{
            if(session.session != nil) {
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct ContextView_Previews: PreviewProvider {
    static var previews: some View {
        ContextView()
    }
}
