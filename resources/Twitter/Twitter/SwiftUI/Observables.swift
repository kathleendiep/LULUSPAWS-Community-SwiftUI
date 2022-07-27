//
//  Observables.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI
import Firebase

class getData : ObservableObject{
    
    @Published var datas = [datatype]()
    @Published var top = [Topdatatype]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("tweets").addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    print("hello world")
                    
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let msg = i.document.get("msg") as! String
                    let pic = i.document.get("pic") as! String
                    let url = i.document.get("url") as! String
                    let retweets = i.document.get("retweet") as! String
                    let likes = i.document.get("likes") as! String
                    let tagID = i.document.get("id") as! String
                    
                    DispatchQueue.main.async {
                        
                        self.datas.append(datatype(id: id, name: name, msg: msg, retwetts: retweets, likes: likes, pic: pic, url: url, tagId: tagID))
                    }
                    
                }
            }
        }
        
        db.collection("Top").order(by: "tweets", descending: true).getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let tag = i.get("tag") as! String
                let tweets = i.get("tweets") as! NSNumber
                
                self.top.append(Topdatatype(id: id, tag: tag, tweets: "\(tweets)"))
            }
        }
    }
}

func postTweet(msg : String){
    
    let db = Firestore.firestore()
    
    // I'm going to use default name and image url.....
    
    db.collection("tweets").document().setData(["name" : "Kavsoft","id":"@kavsoft","msg":msg,"retweet":"0","likes":"0","pic":"","url":" Image url "]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            
            return
        }
        print("success")
    }
}
