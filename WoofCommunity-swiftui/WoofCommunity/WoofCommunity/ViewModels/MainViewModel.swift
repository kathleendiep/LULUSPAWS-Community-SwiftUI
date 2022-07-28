
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    @Published var allPosts: [Post] = []
    @Published var allUsersPosts: [Post] = []
    
    
    // fetch all the users, then add it to array in the view
    static func fetchUser(onSuccess: @escaping (_ user: [User]) -> Void) {
        
        // access users with our removeWhiteSpace extension
        SignInViewModel.storeRoot.collection("users").getDocuments {
            
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
            // initialize it here
            var users = [User]()
            
            for document in snap.documents {
                let dict = document.data()
                
                guard let decoded = try? User.init(fromDictionary: dict) else {return}
                
                // will only show other users id
                if decoded.id != Auth.auth().currentUser?.uid {
                    users.append(decoded)
                }
                
                onSuccess(users)
                
            }
        }
    }
    
    
//    func getAllPosts(postId: String) {
//
//        PostViewModel.getAllPosts(postId: postId) {
//
//            (posts) in
//
//            // put in main feed
//            self.allPosts = posts
//
//        }
//    }
    
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



