
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    
    static func getAllPosts(onSuccess: @escaping (_ posts: [Post]) -> Void ) {
        
//        SignInViewModel.storeRoot.collection("allPosts")
                                             
                                             
        PostViewModel.AllPosts.getDocuments {
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
            var posts = [Post]()
            
            for document in snap.documents {
                let dict = document.data()
                
                guard let decoder = try? Post.init(fromDictionary: dict) else {return}
                
                posts.append(decoder)

            }
            onSuccess(posts)
        }
    }
    
    
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
 
}



