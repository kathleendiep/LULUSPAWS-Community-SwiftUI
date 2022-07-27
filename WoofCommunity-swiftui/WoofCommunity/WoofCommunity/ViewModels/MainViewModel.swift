
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    @Published var allPosts: [Post] = []
    
    func getAllPosts(userId: String) {
        
        PostViewModel.getAllPosts(userId: userId) {
            
            (posts) in
            
            // put in main feed
            self.allPosts = posts
            
        }
    }
 
}
