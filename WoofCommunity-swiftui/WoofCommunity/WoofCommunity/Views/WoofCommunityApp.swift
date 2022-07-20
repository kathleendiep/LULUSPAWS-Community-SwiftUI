//  Created by Kathleen Diep on 7/8/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
struct WoofCommunityApp: App {
    
    @StateObject var session = SessionStore()
    
    // add Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}



