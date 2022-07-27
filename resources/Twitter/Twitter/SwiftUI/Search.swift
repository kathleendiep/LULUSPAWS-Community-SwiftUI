//
//  Search.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI
import Firebase

struct Search : View {
    
    @EnvironmentObject var datas : getData
    
    var body : some View{
        
        NavigationView{
            
            List(datas.top){i in
                
                SearchCell(tag: i.tag, tweets: i.tweets)
                
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarItems(leading:
                
                HStack{
                    
                    Image(" user Image ").resizable().frame(width: 35, height: 35).clipShape(Circle()).onTapGesture {
                        
                        print("slide out menu ....")
                    }
                    
                    SearchBar().frame(width: UIScreen.main.bounds.width - 120)
                }
                
                , trailing:
            
                Button(action: {
                    
                }, label: {
                    
                    Image("Add").resizable().frame(width: 35, height: 25)
                    
                }).foregroundColor(Color("bg"))
            
            )
            
        }
    }
}

struct SearchCell : View {
    
    var tag = ""
    var tweets = ""
    
    var body : some View{
        
        VStack(alignment : .leading,spacing : 5){
            
            Text(tag).fontWeight(.heavy)
            Text(tweets + " Tweets").fontWeight(.light)
        }
    }
}

struct SearchBar : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        
        let search = UISearchBar()
        return search
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        
        
    }
}
