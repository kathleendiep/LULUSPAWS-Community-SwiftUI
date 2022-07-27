
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    @Published var allPosts: [Post] = []
    @Published var allUsersPosts: [Post] = []
    
    func getAllPosts(postId: String) {
        
        PostViewModel.getAllPosts(postId: postId) {
            
            (posts) in
            
            // put in main feed
            self.allPosts = posts
            
        }
    }
    
//    func loadAllUsersPosts(userId: String) {
//        
//        PostViewModel.loadAllUsersPosts(userId: userId) {
//            
//            (posts) in
//            
//            // put in main feed
//            self.allUsersPosts = posts
//            
//        }
//    }
 
}



