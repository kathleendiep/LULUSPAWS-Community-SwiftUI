//  Created by Kathleen Diep on 7/8/22.
//

import SwiftUI
import FirebaseCore

// BE CAREFul what you import

@main
struct WoofCommunityApp: App {
    // add Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            let viewModel = AppViewModel
            HomePageListView()
//                .environmentObject(viewModel)
        }
    }
}
