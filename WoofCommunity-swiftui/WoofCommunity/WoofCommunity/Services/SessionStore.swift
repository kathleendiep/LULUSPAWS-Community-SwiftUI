//
//  SessionStore.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/19/22.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
    
    // MARK: - Properties
    var didChange = PassthroughSubject<SessionStore, Never>()
    // see if user changed
    @Published var session: User? {didSet{self.didChange.send(self)} }
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({
            (auth, user) in
            
            if let user = user{
                
                let firestoreUserId = SignInViewModel.getUserId( user.uid)
                
                firestoreUserId.getDocument{
                    (document, error) in
                    
                    // From extension:
                    if let dict = document?.data(){
                        guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                        self.session = decodedUser
                    }
                }
                //todo: find a way to return user
            }
            else {
                self.session = nil
            }
        })
    }
    
    // LOGOUT - change listener
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
}



