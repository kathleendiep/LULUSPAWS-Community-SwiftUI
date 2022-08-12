
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    static func getAllPosts() {
        let db = Firestore.firestore()
        
        db.collection("allPosts").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID): \(document.data())")
                }
            }
        }
    }
    
    //    static func getAllPosts(onSuccess: @escaping (_ posts: [Post]) -> Void ) {
    ////        SignInViewModel.storeRoot.collection("allPosts")
    //
    ////        SignInViewModel.storeRoot.collection("allPosts")
    //
    //        Firestore.firestore().collection("allPosts").getDocuments {
    //            (querySnapshot, err) in
    //
    //            guard let snap = querySnapshot else {
    //                print("Error FROM getAllPosts: \(err?.localizedDescription)")
    //                return
    //            }
    //
    //            var posts = [Post]()
    //
    //            for document in snap.documents {
    //                let dict = document.data()
    //
    //                guard let decoder = try? Post.init(fromDictionary: dict) else {return}
    //
    //                posts.append(decoder)
    //
    //            }
    //            onSuccess(posts)
    //            print("these are the posts from fetchPost: \(posts)")
    //        }
    //    }
    //
    
    // fetch all the users, then add it to array in the view
//    static func fetchUser(onSuccess: @escaping (_ user: [User]) -> Void) {
//        // firebase.firestore().getDocuments
//        SignInViewModel.storeRoot.collection("users").getDocuments {
//
//            (querySnapshot, err) in
//
//            guard let snap = querySnapshot else {
//                print("error")
//                return
//            }
//
//            // initialize it here
//            var users = [User]()
//
//            for document in snap.documents {
//                let dict = document.data()
//
//                guard let decoded = try? User.init(fromDictionary: dict) else {return}
//
//                // will only show other users id
//                if decoded.id != Auth.auth().currentUser?.uid {
//                    users.append(decoded)
//                }
//
//                onSuccess(users)
//
//
//            }
//        }
//    }
    
    
    static func fetchAllUsers(onSuccess: @escaping (_ user: [User]) -> Void) {
        // firebase.firestore().getDocuments
        
        Firestore.firestore().collection("users").getDocuments  {
            
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



