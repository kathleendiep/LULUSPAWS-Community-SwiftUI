//  Created by Kathleen Diep on 7/8/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
struct WoofCommunityApp: App {
    
    // add Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContextView()
                .environmentObject(SessionStore()) // <-- question: how can i pass multiple environment object
        }
    }
}



