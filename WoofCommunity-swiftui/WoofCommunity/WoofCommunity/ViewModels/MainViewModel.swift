
import Foundation
import Firebase

// to show posts in the profile
class MainViewModel: ObservableObject {
    
    // fetch all the users
    static func fetchUsers(onSuccess: @escaping (_ user: [User]) -> Void) {
        
        // access users with our removeWhiteSpace extension
        SignInViewModel.storeRoot.collection("users").getDocuments {
            
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
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



