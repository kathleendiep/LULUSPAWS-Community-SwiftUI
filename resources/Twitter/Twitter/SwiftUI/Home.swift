//
//  Home.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct Home : View {
    
    @EnvironmentObject var observedData : getData
    
    var body : some View{
        
        NavigationView{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading){
                        
                        ForEach(observedData.datas){i in
                            
                            tweetCellTop(name: i.name, id: i.tagId, pic: i.pic, image: i.url, msg: i.msg)
                            
                            if i.pic != ""{
                                
                                tweetCellMiddle(pic: i.pic).padding(.leading, 60)
                                
                            }
                            

                            tweetCellBottom().offset(x: UIScreen.main.bounds.width / 4)
                        }
                    }
                    
                }.padding(.bottom, 15)

            .navigationBarTitle("Home",displayMode: .inline)
            .navigationBarItems(leading:
            
                Image(" user Image ").resizable().frame(width: 35, height: 35).clipShape(Circle()).onTapGesture {
                    
                    print("slide out menu ....")
                }
            
            )
        }
    }
}
