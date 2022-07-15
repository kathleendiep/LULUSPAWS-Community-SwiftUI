//  Created by Kathleen Diep on 7/8/22.
//

import SwiftUI
import FirebaseCore

@main
struct WoofCommunityApp: App {
    
    @StateObject var viewModel = UserViewModel()
    
    // add Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {

            HomePageListView()
                .environmentObject(viewModel) // why do i need this
        }
    }
}
